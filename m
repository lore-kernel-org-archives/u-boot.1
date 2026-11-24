Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D09E606A31E
	for <u-boot@archiver.kernel.org>; Tue, 24 Nov 2026 08:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=0cjrFuDQ;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=njtThc1I;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=njtThc1I
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 12F684077D;
	Tue, 24 Nov 2026 08:37:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Bf6KZOWzgOUU; Tue, 24 Nov 2026 08:37:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 239774066C
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795509469;
	b=SKsFM6HtEz16kKCEhETfNF4BX/Iyu8REHWbe8LebXXnIKCueEMB1lZfSK6NG3RgwbuwO
	 T4Sll4WyAal28boc26yvtvXQo980zwecfXNlG1GE7f3aOMe6GKrNusXRJkeY6xZEJdjEW
	 QyLhkZuqfx2AQCACiBrzL5d0OZ8/GXZLaswlBRPISqJmX7pbb2AnrbTXOgt+yZ1TFrqqG
	 /VCG0dOppcnxpihbz9obGQ6dv0G5lBqnEpRWKwb7bYH87ID7KeWOArl/4PCsxZ7rAENF3
	 V+MLot/VdorScWKLNvqsS968t8m/i5DpIgn06+jNCb1NcJsqdBRnJzNwQCzOSKvqtAQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795509469;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:DKIM-Signature:Authentication-Results-Original:
	 Received:Received:Message-ID:Date:User-Agent:From:Subject:To:Cc:
	 References:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 x-checkrecipientrouted:NoDisclaimer:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam-Untrusted:
	 X-Microsoft-Antispam-Message-Info-Original:
	 X-Forefront-Antispam-Report-Untrusted:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-EOPAttributedMessage:
	 X-MS-Exchange-Transport-CrossTenantHeadersStripped:
	 X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id-Prvs:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=jvMuika3EX/NmouPLQGRIp7vCXtfmzoL0fPeaZkVycY=;
	b=Vc1W7ZMQnoV0C9rLx835K+vzdnCJ8Xy8iXxcH/coZGTQdh16aH7PhTocDXixXojod/7H
	 1kLuQs6gisNlXCemm3hMZXA4kCRC2KFvOSSM3WXjHdi1/xYW8yAPypJr65KbuULvcD7MC
	 0ZbR4VcgxCfRQGaZSSCW+GYEr9E2bpDjAeyErQfrhyUQ5D5l7EKf86TbuDph62MpMdh9v
	 +OMqEC2JimDh45IiWCuZ1ysuA1DpaGiSNRztZw3JAKYijdINDDJKWDkg5ZI2xK8qbrC3i
	 fQch4ljSbWBxfMqpcnYD0iKHTLgb6nMX9BuquTfFHnjFMQlKYjZOjPxNSuH+2CGkLxg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=njtThc1I;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=njtThc1I;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795509469;
	bh=jvMuika3EX/NmouPLQGRIp7vCXtfmzoL0fPeaZkVycY=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0cjrFuDQfP/R6qETUG42mB7LcdJpoNTcAZPyAtyOPSIuJNU5gFDjy8ykBOvWgaK9q
	 x8Gtush2w1RQKjrOJo1E+GbFeHi4RX3UJqX6TaLizNxu6lrAbIiDy/KDMNidLYDPXT
	 e1vSc+BHhc7gMIh2mi/ewazX+OhMOWv5irbpaLx1LELCsErKkpZwrRr4LaxD97AGiZ
	 v8v91ST/jhV39a6tei79fOGIWgau13hR54goxAP+ZBN2FVw4KjJ5KQqUgnPNT+x8nU
	 MzOpXWnxkkMAswTaQ/NwsXDAt/VJlrcFqaWoxa76ZG/Bfx3qjttqSIJ6v9/B1f9HOa
	 ++FkVUyYYWoCQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 239774066C;
	Tue, 24 Nov 2026 08:37:49 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 9165F1AB
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 08:37:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 82BFF4066C
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 08:37:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vVq4mOfZOtJ7 for <u-boot@lists.u-boot-project.org>;
 Tue, 24 Nov 2026 08:37:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 9E51A4054D
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=2
 smtp.remote-ip="2a01:111:f403:c200::1"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::1;
 helo=db3pr0202cu003.outbound.protection.outlook.com;
 envelope-from=jerome.forissier@arm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=njtThc1I; 
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=njtThc1I
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9E51A4054D
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 08:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jvMuika3EX/NmouPLQGRIp7vCXtfmzoL0fPeaZkVycY=;
 b=njtThc1IGjsBtFfir1O5mwUZzQ7sImaXWRLLPEueY0oqYuaPF1TjvlYUesarEnMTJKvo0/GjT5snpa6Wouh/VmQQ/oQQocPOhzhLcg56Suk6TFFG1HSrzgawp/LbMfKmRaCqWglLd+nPmNKrfMPNsWY8H6yWqHiPjBPPL+6YpQA=
Received: from AM6PR04CA0046.eurprd04.prod.outlook.com (2603:10a6:20b:f0::23)
 by GV1PR08MB7986.eurprd08.prod.outlook.com (2603:10a6:150:9e::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Tue, 24 Nov
 2026 08:37:38 +0000
Received: from AMS0EPF00000566.eurprd02.prod.outlook.com
 (2603:10a6:20b:f0:cafe::12) by AM6PR04CA0046.outlook.office365.com
 (2603:10a6:20b:f0::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.14 via Frontend Transport; Tue,
 24 Nov 2026 08:37:38 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com;
 dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AMS0EPF00000566.mail.protection.outlook.com (10.167.242.116) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.3
 via Frontend Transport; Tue, 24 Nov 2026 08:37:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jvMuika3EX/NmouPLQGRIp7vCXtfmzoL0fPeaZkVycY=;
 b=njtThc1IGjsBtFfir1O5mwUZzQ7sImaXWRLLPEueY0oqYuaPF1TjvlYUesarEnMTJKvo0/GjT5snpa6Wouh/VmQQ/oQQocPOhzhLcg56Suk6TFFG1HSrzgawp/LbMfKmRaCqWglLd+nPmNKrfMPNsWY8H6yWqHiPjBPPL+6YpQA=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by GV2PR08MB12001.eurprd08.prod.outlook.com
 (2603:10a6:150:369::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Tue, 24 Nov
 2026 08:36:59 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%6]) with mapi id 15.21.0639.012; Tue, 24 Nov 2026
 08:36:59 +0000
Message-ID: <a56e8f89-585d-429a-bdf2-2c3282eef434@arm.com>
Date: Tue, 24 Nov 2026 09:36:58 +0100
User-Agent: Mozilla Thunderbird
From: Jerome Forissier <jerome.forissier@arm.com>
Subject: Re: [PATCH] net: ksz9477: Constify driver ops
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, nd@arm.com
References: <20261116173936.3488088-1-marek.vasut+renesas@mailbox.org>
Content-Language: en-US
In-Reply-To: <20261116173936.3488088-1-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P302CA0030.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:2c1::16) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR08MB11733:EE_|GV2PR08MB12001:EE_|AMS0EPF00000566:EE_|GV1PR08MB7986:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a4e309f-1609-45b3-6d26-08df4a063183
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|10067099003|11063799006|56012099006|261021121427099003|261021123027099003|261022105027099003|261026140227099003|261009223027099003|261028144727099003|261102123227099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info-Original: CqZNK15I0RaLKcyn3wFauS8aXJjKYy9DedO1r62uMgcugNrm32Irv8sa4IO0B6Ct8+5aQgWPPGb9qzvV1hKV8VIcI1ucNLTvGqb2q2+8jW9tn1CVU0Qv4aVrtEt2g/BEGRbTKQy9D1uMgDAt8mfYLKGMkZxnXBR8QOmLzvqUl/VKovb8v7oQd5nzKVzL/xiUfEHAv+qcG2tH/EH0vR22hdrLiIo7oNRHbnvYLOC97lqRfTL6dWSYE6npdhnMKk1lTPJaR7xA9kEHWPE4IgpIBis3UhMMbyisZ2Q7ldxtTDzrKs6DGraWIRfrFkTL6Vl5JpQCSuLJ5p6albj43p/YuGgKej+fdfc+r/0aPCEpYztXrqTkdzqB4S4RfDCR6DWa+aGW12nBVMbK/NIbjVmGF01MTMYzcaBWVbsgNHa82eSqoAUHQoKuh62YLuww2uUp4cJRI+P6hOv9u0rbnCYfc10PJImGgRcFgZ+gKMnIjWO5/cg5ZgL/CID0e+Lw6d2WZ3ZKDd6cOg7/dESgThdWiCjamrB5vehyLGkD4+u+Fqn35lawyqdkmgK3LYduGT5Tc4TeGj5OaxaQLePMZaPKHEGx2MIhVdUdqvlpgUX6HE86Fk+AdG8+53XB3xvQQBGx
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB11733.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(10067099003)(11063799006)(56012099006)(261021121427099003)(261021123027099003)(261022105027099003)(261026140227099003)(261009223027099003)(261028144727099003)(261102123227099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: I4OfN9BIfQw2wnUYBSPcBCFWNcKMhbMqvoCVjHV96yJa0P2VcpD1OugBqGOLQyDjZezjwsl/f556/rYCK4iKTMCh18mwlxbD67zKGHjNw03QwKVo2Rj7WBempXIoAI9BMkY7y/RROxJo2Q1swJ9PsvFZzfj7JUZX0VCJoRY7Mv0f61Ki/fTN/WOOpjDVpDqPARmRCGc69rpjE1FplJPVEuQoaMcgIPiVDM3NOuP/isFkX5ZLYZn9N0pyL+uLDbtTdFfTOLcGecQcedzFSxrCphh3zxoCfHJeMbwEE6yx4rdG4bQNyp9+dgC+vPJsL5nuk0Alr6LMBnSjvb4IYHhE9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB12001
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AMS0EPF00000566.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 55d269fd-5237-4fa1-6d15-08df4a061ac6
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|35042699022|1800799024|23010399003|36860700016|14060799003|82310400026|10067099003|261021121427099003|11063799006|56012099006|261026140227099003|261021123027099003|261009223027099003|261022105027099003|261028144727099003|261102123227099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: /jfu7scc9jOFAjpXYEk3EuY01WNztm2q9yiKBC5238wFAflV5qR17NfbsY9MQJ48uM30Us0Sy+G/aseEaMdn8+ITmiNVkUvpbRHAQ6dkMeNQtd1bFXZQ2pNek2Dwi4CdVWM9C8F6IySbtkobH3xCeQsbQvPDK5opu9ufAahK1eiDHqWrOZwqatfqwrke0OTTzFoGRE4b2z4L8iI/kYUUSsCxCwvLQufuPFd854Li9ZaNRQk4MLPNNv6ntTSUDrgg6JdN0xLCZxn/WCXHZosb0FCrQCbjOYtmONQVMcHOa5Bz5d+L7ZJX0bYpIh5gmPTosf8Lx29M1LifbOvRfxaPwRsV0vwWyj4J2jVk6MwzX1N5JNOgLVLULkdHpyO343T3rAwlyhFhUvWMp9YSWbkP77tiCpt3TiPvwWSLKJO6njMuQlphXee3+B+igy2Ll9MTnQCsHDL4PbgQX0Tfi7ZTCUzX3yIV0G3gCk1EqoHJQ+U9biz6WkmA3ds82vQV/d6vNhQaKKH3TWRFWh1q8UP+fKdwPxJ3yCRMpkfLKV4mZ3R5EVVW/+SpeRQ7TApu6Z473jxYUSJTrWEUoC/bLd+Mi9GZjIQDZDMuxjBYuH/xt11XFVmzEpD/fSir+tqOcGYu2pqSmaZjAevjLwxykizSRHS0Yx4jdy+gKKgpAfHapXQ=
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(35042699022)(1800799024)(23010399003)(36860700016)(14060799003)(82310400026)(10067099003)(261021121427099003)(11063799006)(56012099006)(261026140227099003)(261021123027099003)(261009223027099003)(261022105027099003)(261028144727099003)(261102123227099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: sBZ9G7PBsxt4iNg/VGbzZNvVVO522/bdHb5rl7UfyzhkF3RfAlPHwVcNT5FsncePaD+sCZZ6a18hazgSE7ATnQ0oqQ/GeKbkWp67pwJ9b+ePVAh/F5OA3pjla9rFSQC71KGIy+zALHQIbuYk+HlAn4tDP7Po44q6EEX1h0kquA/BWYzUoxaSkrYyGkj85xspK/nP/xwbaz2mOpWqoEG9ZBk/nxiWMWnDiuiBwGL1ggyzs9PsggDSbzZkX2J8ptaw50T/5srM4gRQ8dicltDCKSzzxusZO4SMt0UdoQhdK4ckHmX6ejfdWgBra3O9dI023PfhEbnBDkV4APXQ1AuKSLYBllrt4SjYcnzC+B5lq6CmwQx3B/rU4rXpV9RLKHfl6IIepuXQhLW4WHz8jVk3ReOjip2Doont/gbD+YmneUt8Hrp5//IAlB++2Tv/duYf
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 08:37:36.9879 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a4e309f-1609-45b3-6d26-08df4a063183
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF00000566.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB7986
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-22.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> Set the ops structure as static const. The structure is not accessible
> from outside of this driver and is not going to be modified at runtime.
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Jerome Forissier <jerome.forissier@arm.com>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: u-boot@lists.u-boot-project.org
> ---
>  drivers/net/ksz9477.c | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)

Applied to u-boot-net branch for-next [1], thanks!

[1] https://git.u-boot-project.org/u-boot/custodians/u-boot-net/-/commits/for-next

[1/1] net: ksz9477: Constify driver ops
      commit: 30a43090341dcc6b42bb9c08d4e3d51f3721992a

Best regards,
-- 
Jerome Forissier <jerome.forissier@arm.com>
