Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80149606A333
	for <u-boot@archiver.kernel.org>; Wed, 25 Nov 2026 18:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=HomwbHmU;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=IBlneFuo;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=IBlneFuo
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5A81D81004;
	Wed, 25 Nov 2026 18:20:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rc4napYRO68R; Wed, 25 Nov 2026 18:20:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 5116580FB1
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795630850;
	b=RgL5ptTZJsx+1vod+L9Pw8VUnwUNPMWvM5fPNEvGmdjx9E7fQPDOe2LfE+DQaRcqy65X
	 8Aj5fN+Df57mOeuK996P3TWpjE+y0ZUJOyxwB/AlcygO7eZLfvo081C6GAG2ypLwsvOqG
	 1rmvTLB+A12ZnV32ErCf69yUDMQ6gfHRCpzioXykKKXuhT8ksEj48yho04/Z+0Q3n1jtM
	 EJmqNU1REjqoeNv81rzMgFYFohMm55SZETOXNQqjmIVy3edgFUY/9Lmy0mDIGWQNDIz/l
	 9X3Co58Ke0eWzzJoECEok6TIxdLaT/T0In9UX2hI03BatanW8PtOqWi5wY4r8esrrSw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795630850;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:DKIM-Signature:Authentication-Results-Original:
	 Received:Received:Message-ID:Date:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
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
	bh=CKHZUhOVk2kCvTf0sUDlTUWbsKpJPobjLS8wLtZZJao=;
	b=Mmu0Xw8KN3ULslvBhmmFhRa227Kt0jfo+C+mMUMHAF6Ge4q9JBHgH7YJ/MX6b8NsgI7D
	 En8gL1QKqZXh3BZ6noFW9iK6392fVGiZDJDDFmQ5XW0cLf8qrk1RO3ul9vBQvEe2p8EYn
	 WwlXiejT7aqJdtrTOUjlpbSs/AnNYzPGLNKWIPpNcakw7ZnwSQzQbW6xsJyXeQXwF3uBf
	 IAt7dVWcDPszZ9v3zOg88Q03s56ClS1ICU+3wSJ+TILEEnHXsZh3OwY9slwOYPfT3aeF1
	 JrEmPqomFCHKeuOOe24jYlgOQ8UWjL8tjK1ZhsfP323SJYlgnMSdHzCp/TPMAFcd37w==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795630850;
	bh=CKHZUhOVk2kCvTf0sUDlTUWbsKpJPobjLS8wLtZZJao=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HomwbHmUh/1dX6Sn27WYY16ebsZIhNP0FNDyNkOiLjB7cAQXsOhgXXSgzr9pPEvpE
	 EOdYGVncdh3H7IDetw4GhMj7sx7EYYZQbJjU/8AX9urofhJmVT+R3QI8ZIOeKuglgA
	 SvxnxHdaPby/brhJ31dQCFj3e0CNomQMKHsZ2R6GffyMk2elul78RO6Ju+U56mVIqG
	 Zj7TWalLyWGkif7zXHVIypEo0FU25dlI22ERd64g9A5DOls6RdQe5fHKIm+lJk7db8
	 t9SrYvrZkOOLEKHAyz/R5vWxSXTO4PiIxhgI21UkyyQnYuPM2y1BJ6cHDlxpmr5WQ7
	 Li3HjBdkayndQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5116580FB1;
	Wed, 25 Nov 2026 18:20:50 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id BBD2032D
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 18:20:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id ACDA3607BE
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 18:20:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6sLwIjBzf5sd for <u-boot@lists.u-boot-project.org>;
 Wed, 25 Nov 2026 18:20:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 0C5FC60758
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=2
 smtp.remote-ip="2a01:111:f403:c200::1"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::1;
 helo=db3pr0202cu003.outbound.protection.outlook.com;
 envelope-from=jerome.forissier@arm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=IBlneFuo; 
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=IBlneFuo
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0C5FC60758
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 18:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CKHZUhOVk2kCvTf0sUDlTUWbsKpJPobjLS8wLtZZJao=;
 b=IBlneFuobrNb+zgDrYR1sqhywtXWAJ78IM4FRFXA/ZvxJgA1Cm+nDfqwnCymTicinbDqFhiKTzvb9+yPCKRQw8W0EwJNOk5oVZgrBYk3Pl1j4LUwZd/dQRQW8m0imYxYDpAYoFZHOGdN+ezaGCw0sU1SbvoASmVfsc+QNdzJqtU=
Received: from DB7PR05CA0104.eurprd05.prod.outlook.com (2603:10a6:10:36::27)
 by AMBPR08MB915345.eurprd08.prod.outlook.com (2603:10a6:20b:7b0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.6; Wed, 25 Nov
 2026 18:20:40 +0000
Received: from DB1PEPF000509F7.eurprd02.prod.outlook.com
 (2603:10a6:10:36:cafe::4c) by DB7PR05CA0104.outlook.office365.com
 (2603:10a6:10:36::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.7 via Frontend Transport; Wed, 25
 Nov 2026 18:20:40 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com;
 dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB1PEPF000509F7.mail.protection.outlook.com (10.167.242.153) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.3
 via Frontend Transport; Wed, 25 Nov 2026 18:20:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CKHZUhOVk2kCvTf0sUDlTUWbsKpJPobjLS8wLtZZJao=;
 b=IBlneFuobrNb+zgDrYR1sqhywtXWAJ78IM4FRFXA/ZvxJgA1Cm+nDfqwnCymTicinbDqFhiKTzvb9+yPCKRQw8W0EwJNOk5oVZgrBYk3Pl1j4LUwZd/dQRQW8m0imYxYDpAYoFZHOGdN+ezaGCw0sU1SbvoASmVfsc+QNdzJqtU=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by MMZPR08MB980551.eurprd08.prod.outlook.com
 (2603:10a6:190:46::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.6; Wed, 25 Nov
 2026 18:20:07 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%6]) with mapi id 15.21.0639.012; Wed, 25 Nov 2026
 18:20:07 +0000
Message-ID: <90fdb9ac-139b-4691-8d54-e832050f8bec@arm.com>
Date: Wed, 25 Nov 2026 19:20:06 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: make default address settings available with lwIP
To: James Hilliard <james.hilliard1@gmail.com>, u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Quentin Schulz <quentin.schulz@cherry.de>, nd <nd@arm.com>
References: <20261123-submit-lwip-net-env-defaults-v1-v1-1-db2e3436c5c3@gmail.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@arm.com>
In-Reply-To: <20261123-submit-lwip-net-env-defaults-v1-v1-1-db2e3436c5c3@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0403.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:189::12) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR08MB11733:EE_|MMZPR08MB980551:EE_|DB1PEPF000509F7:EE_|AMBPR08MB915345:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f1ebb62-ca64-4b6a-1710-08df4b20cf61
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|6133799003|261009223027099003|18002099003|22082099003|261022075727099003|10067099003|261102123227099003|56012099006|11063799006|261021123027099003|261026140227099003|261022105027099003|261028144727099003|261021121427099003;
X-Microsoft-Antispam-Message-Info-Original: b/SvFG7kZ4INIAebzzhALgQ4s/Hreumb4mmSR5VbYNuI1J4cmKbBhoT4pmLZXatqeD1quCPrqagSyC62ORV0Tdn4eFywiIeBIruJIcsYVG9siMguzfn/HNIezBe0tcxkwXvy73GThMMnEOhoBdAB7sMT9TiOiiUpS/XXZHuzBn/23tMSUBwF5JrxjA/MELpqH0YPnyLKkBbGv6IDq0FObWlnxrvY+R8ehn8QL0gO7h5JiybIRtjQrxbY4Ik8aPPYABQC/6HUwmGkC1LgefbpyDUh/kUrhgnCOOxTVkhtb/I1b0t7UtgRK6s8GskuEO0e5wY3mVDX/TOLxMELp9tvIJzqLy5WIAwJLraoVq0uTiq4kTnRz6XWMDqcxcZ4h+FKnZUAuwNdRaN/ttupJTlnJFA2NdoWaanolGiRuEcmGl9Gp+BFpWSqWx5RO8j+devwKqeU9ecy8avtHesCCpy1zXmsPUDz+GNJxGF+vDaQm/++rkH1j9pydQ/NFGfkSuG2YzT+XiEur0VAekqBtgf88O3QhdU4LPpo7nZOeQpXcZCOMvwTRAlZS8TivEgPdGK063Nx4HeH+OBUYt9chVoxruhQRMVdcyBVMHG7M8VaTAU=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB11733.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(6133799003)(261009223027099003)(18002099003)(22082099003)(261022075727099003)(10067099003)(261102123227099003)(56012099006)(11063799006)(261021123027099003)(261026140227099003)(261022105027099003)(261028144727099003)(261021121427099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: aXIIakVMAfBbfWpgUcTqHtJEVfwY5X+XdkN83X7TLf/68mjwrwLn7VrtHV9Y7zqAbpuHDzKoT0CMWKyLivFdCE2YnlJWhCvb4M8PlZSbVSnMPM1P5dyrF+oYoBDYfUzXQ95oHPny/AQ9mLSzZxsJPV0H/cPqyO73g86lbkwVhJRNNwJZQX4mixMBlf5NyqUogBxKximDuj7WRmpiK/Mfzeeu9fePcDHDZHHPXTpXi9s0s8LDfzoBeVHztyCdbl1PxE1+bQPyQjs732j12XgX47ll/ALebaxmYBWA06nT6rar5Uhzh3KAvxiud1IVmcyy1E93ChJs3buK99AspIsNag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MMZPR08MB980551
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB1PEPF000509F7.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: aeffe8d5-dd8b-4f92-591f-08df4b20bbfa
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|1800799024|14060799003|23010399003|376014|35042699022|6133799003|18002099003|22082099003|13003099007|56012099006|11063799006|261022075727099003|261028144727099003|261022105027099003|261026140227099003|261021123027099003|261021121427099003|261102123227099003|261009223027099003|10067099003;
X-Microsoft-Antispam-Message-Info: 2yKqIzX5P2/Vbr1Q3klbJF4rhdgD892G0NbjHxJhVx/Avrl8TGhfU3UUMeeMeDLwtdT/AYmEXc1P4p5kokd6byI+iurj0LAmAEJpzG0vBWok/aKJel8HWP7gOaXFa70NnkSl0ge7uCTcrFz+PZ6Zevf1YDaFERolO+OC8rVNOv09OVniKEUThhPautGuscrAC3dF8TKv8I0RoB7tee4qSNBxG8SNECdXwhFS9+V17CXGc5KiT5OGM4cDck0NeHaAs1fQcqn7C+/ifKAZFPvILoX3vCNhJwwDCdpLxCE5W8aYNppHcqqDybEP6A6GhrvyIDJYyTUDYFw8LPPoe8U1MqIMsMXH3IovaHmHNPYx+Ulee4A6hVkUM1a6JCFkdD862lpaMteIbDsB3SfCuqQ3EHw5AuhS0pX5wnFzMDF3wxD2MqMxKwaKyGh13Xe/QoP++ien7AyrNe6nON4ai7ztzE5YpPg6waFBtj2xYBg7ivJVYckL2UIf4UBUEbvrFlRG3wvMwtisA57ueEroFWQzWT43ziEbNAge5oQrz/4Pu1S43uhmjf6EJby8dusJJjwRmB/21cjcM71vN6+zFT537AS4jgyMyjB/oAWYl+z9WMJRljgcY9tSTnUJyJG1sEcFU5o0SXW2aW3AHky7UJQ7Ng==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(1800799024)(14060799003)(23010399003)(376014)(35042699022)(6133799003)(18002099003)(22082099003)(13003099007)(56012099006)(11063799006)(261022075727099003)(261028144727099003)(261022105027099003)(261026140227099003)(261021123027099003)(261021121427099003)(261102123227099003)(261009223027099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: REsVs3hAgpxMCupRAHsCg20t/mSi8vvn0aS1Dwyf0yUOla5Ks/hoIYH2sWEOsbeZYOHZV6TmqyOtzd/VdnPFMm99AuBe11iPCmgtLsG7tuVUf603RbGPYbYqfDFCy6NtejrjQ+4Fn/EaX4YnpIfDKET/dAvhKBX3q4gGpdjOWEPfPA+tmWpJ/JHtH8esOYRFNz6BDvP+Bm08dlC56Q12oaTBDQ5YnQHfi9BCyRgqtp0Kfeix3fnJN0YTL9MygiIQggJukT25j8T37dVMxtRlQuZBvOLZ/BfQJyMQ7hjIZrWcAdMiT0C2M9AyqlSi/JCxiPqvrDOyMDU/6uAIK0nli1dKCLHt1IhhdFWp1ThiwAADjgAH7lxxIZlDXgEwcOnElmKGqBwMNm7aiGyHadTyTEnZj+w23LLcP3b4IZ1hffGAUYZc5iqTdBCP+N7y96rL
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 18:20:39.9198 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f1ebb62-ca64-4b6a-1710-08df4b20cf61
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF000509F7.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR08MB915345
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

Hi James,

On 23/11/2026 23:21, James Hilliard wrote:
> Switching a board to lwIP drops its configured ipaddr, netmask,
> gatewayip, serverip and rootpath from the default environment.
> include/env_default.h already emits these variables for either stack,
> but Kconfig hides the corresponding options behind NET_LEGACY.
> 
> Keep these options under NET so board configurations can supply the
> same defaults with either stack.
> 
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> ---
>  net/Kconfig | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/net/Kconfig b/net/Kconfig
> index 6d6672b9662..61e47838dbd 100644
> --- a/net/Kconfig
> +++ b/net/Kconfig
> @@ -175,17 +175,15 @@ config BOOTP_MAX_ROOT_PATH_LEN
>  	help
>  	  Maximum root path size, including the terminating NUL byte.
>  
> -if NET_LEGACY
> -
>  config USE_GATEWAYIP
> -	bool "Set a default 'gateway' value in the environment"
> +	bool "Set a default 'gatewayip' value in the environment"
>  	help
>  	  Defines a default value for the IP address of the default router
>  	  where packets to other networks are sent to.  (Environment variable
>  	  "gatewayip")
>  
>  config GATEWAYIP
> -	string "Value of the default 'gateway' value in the environment"
> +	string "Value of the default 'gatewayip' value in the environment"
>  	depends on USE_GATEWAYIP
>  
>  config USE_IPADDR
> @@ -222,13 +220,15 @@ config USE_SERVERIP
>  	bool "Set a default 'serverip' value in the environment"
>  	help
>  	  Defines a default value for the IP address of a TFTP server to
> -	  contact when using the "tftboot" command.  (Environment variable
> +	  contact when using the "tftpboot" command.  (Environment variable
>  	  "serverip")
>  
>  config SERVERIP
>  	string "Value of the default 'serverip' value in the environment"
>  	depends on USE_SERVERIP
>  
> +if NET_LEGACY
> +
>  config PROT_TCP
>  	bool "TCP stack"
>  	help

Could you please split this: one patch to fix the descriptions first then
one to make the default address settings available with lwIP?

Thanks,
-- 
Jerome
 
> ---
> base-commit: d778970a189b977c14f93961d7009f404d895b5b
> base-tree: https://git.u-boot-project.org/u-boot/custodians/u-boot-net.git for-next
> change-id: 20261123-submit-lwip-net-env-defaults-v1-330a6588a9ea
> 
> Best regards,
> --  
> James Hilliard <james.hilliard1@gmail.com>

