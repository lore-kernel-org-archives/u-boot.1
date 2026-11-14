Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96205606A32E
	for <u-boot@archiver.kernel.org>; Sat, 14 Nov 2026 02:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=xwvsRgCz;
	dkim=pass (2048-bit key, unprotected) header.d=phytec.de header.i=@phytec.de header.a=rsa-sha256 header.s=selector2 header.b=kmkfzmRv
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6653D81686;
	Sat, 14 Nov 2026 02:04:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WnvwTXwKoHz1; Sat, 14 Nov 2026 02:04:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org A1EF181704
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794621880;
	b=M8WsCD8mFMMbkeCe6LfSTi8zhFiWkVckuSUwIePl4v/fGIQzIjQ5JX42pom7ee13lGCq
	 Yl5csYtF1OJR+WG/wQ0SpdhiyMKT2aVjvxSv1FItcGCnf1XM9N1Zam+xZfY5GkYlEkD2j
	 7K6m31YLGYRuiPQouEgae5PNUbSJYFuB+gibJ6dTE1eENRU+TpnbrDqsH4hh5sd9Xs7C5
	 1UB/0B9Zp8gWQsRtpye8eX1zHWtiB8Hzyd/sLHbbDolNuWNBRu5SgfqqhRTuVMesy0jzy
	 SQLtlAwtN4m6LO+qSebLJ4tKQHLW4EhpRX/Cd4rIHEGkJIHxVs69To25xSY0bDn1iYQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794621880;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:From:To:CC:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:Content-Type:
	 X-Originating-IP:X-ClientProxiedBy:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
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
	bh=deLhvQT18jXlU9Je/WwxjH9+kIGG3UwUehk+9yMIyzU=;
	b=fjfAYJxJM/LVaDyDXWnrLx7A3Lw+UUNQ8l89BOtK9Kwp4rn39bEBVJm7TZKCNGPpJ4z4
	 nEQlwCrUrMB5SPzI47ypNQX0323J5N4lV6Ke6fjIP1BxfGKMskDJJeMXelbOalTWMLtn3
	 DrqpxPVH0cp58j4OWD06K3bgdK/1GOpSXXoHpQ9I9odoqqk9rQ7R7OM9a5XNi/wJXtJxL
	 G+iDVazrANQ6V8RqkTaQOzBqj9waBnrOATNVWwKHQO10RadmcLfeJCJU2nE1n6HRoJ19l
	 5NBMbvKrW3Z4D965nsbVCw7CWP06m8WtB1E6m0XbqQ/DZSMobkLpF4toAVNmAaDN6Dg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794621880;
	bh=deLhvQT18jXlU9Je/WwxjH9+kIGG3UwUehk+9yMIyzU=;
	h=From:To:CC:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=xwvsRgCzFDrFU+IJW7jp5BfbIbuVsZ6AvaeofDQBtWxbMr/mK+W3olrmy5XIpwsmP
	 QojZlON4vWJzPshfy/bgkEFZcfUFhkbdQ18HT52HF4fKm0hL5ALe48Nu+EXniVv6/L
	 +YyaUi417xjC/GqraxA+rzxNEWSatrx5kLWwHd/O8R6FlaeWhFeX3iJN6QWGsgGy6p
	 c/aOVLDE53cJVzqZJKZgNssNeeHDFB0i/V3JDvb3bF3Mg/j06gTa+Xpg/a0D353u2y
	 gRogUHjO6quu/on9wtFzgEpx0ETHK0VVbSiqojYHGlec0eh4rpF23mLpEX0GHXnaq6
	 mwgOQJ4/2P2LA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A1EF181704;
	Sat, 14 Nov 2026 02:04:40 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 6582D150
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 02:04:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 42FBD6077C
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 02:04:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7X6uM-F6LxQS for <u-boot@lists.u-boot-project.org>;
 Sat, 14 Nov 2026 02:04:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 071A16071D
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c200::1"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::1;
 helo=db3pr0202cu003.outbound.protection.outlook.com;
 envelope-from=d.haller@phytec.de; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=phytec.de header.i=@phytec.de header.a=rsa-sha256
 header.s=selector2 header.b=kmkfzmRv
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 071A16071D
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 02:04:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=deLhvQT18jXlU9Je/WwxjH9+kIGG3UwUehk+9yMIyzU=;
 b=kmkfzmRvGkFAlLfsXkgsIVYMOXYXYk2qWdhkFGhmCaQrZyrkOCfnUadUoN1GSbkLW5oF1/CRUFGcOAM2jWm3G5mQ+xbWhyH/KQoxJyW2+1u/0fJ9NPwRnvHtSj5zlCQgWaAT+zD0xHSTmUZW2HT+4ldTJn9iRI2TT9+G0JciTV0lTLsKBaGIVyiLDNVD6Xn3UKku7X4fIKAlUDAXYqCzC/+psujQ67dBmvg4SAkBUuv8ft0DaHwCn+GQLAA4wR/X8zQlu6WckrZIHLCUh7nzC4eizybTwWL1/bKbu2OeeTq7iNeLc2lwvvnB3tIIryvS+2luveuFh2u+JzPObkR8lg==
Received: from AM0P309CA0015.EURP309.PROD.OUTLOOK.COM (2603:10a6:20b:28f::15)
 by PA1PPFBBC768893.EURP195.PROD.OUTLOOK.COM (2603:10a6:108:1::1df)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Sat, 14 Nov
 2026 02:04:32 +0000
Received: from AMS1EPF0000009D.eurprd02.prod.outlook.com
 (2603:10a6:20b:28f:cafe::24) by AM0P309CA0015.outlook.office365.com
 (2603:10a6:20b:28f::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.0 via Frontend Transport; Sat, 14
 Nov 2026 02:04:32 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 91.26.50.189) smtp.mailfrom=phytec.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: Fail (protection.outlook.com: domain of phytec.de does not
 designate 91.26.50.189 as permitted sender) receiver=protection.outlook.com;
 client-ip=91.26.50.189; helo=Postix.phytec.de;
Received: from Postix.phytec.de (91.26.50.189) by
 AMS1EPF0000009D.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Sat, 14 Nov 2026 02:04:32 +0000
Received: from lws-haller-privat.attlocal.net (172.25.39.212) by
 Postix.phytec.de (172.25.0.11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Sat, 14 Nov
 2026 03:04:30 +0100
From: Dominik Haller <d.haller@phytec.de>
To: Wadim Egorov <w.egorov@phytec.de>, Tom Rini <trini@konsulko.com>
CC: Dominik Haller <d.haller@phytec.de>, <upstream@lists.phytec.de>,
 <u-boot@lists.u-boot-project.org>
Subject: [PATCH 1/2] board: phytec: phycore_am62x: Limit RAM_SIZE_FIX
Date: Fri, 13 Nov 2026 18:03:57 -0800
Message-ID: <20261114020400.131274-1-d.haller@phytec.de>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: Postix.phytec.de (172.25.0.11) To Postix.phytec.de
 (172.25.0.11)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS1EPF0000009D:EE_|PA1PPFBBC768893:EE_
X-MS-Office365-Filtering-Correlation-Id: 88b90b3d-1497-4ed8-1b02-08df41f39fcc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|23010399003|36860700016|261009223027099003|18002099003|261026121527099003|11063799006|10067099003|261102123227099003|261021121427099003|56012099006;
X-Microsoft-Antispam-Message-Info: 9eCy2xqkBADJR9o3ttl5u5f1MukLjT/0kSp9PE6oUUDEJ9SQKMo+eTLmv1gv8iYo2Md/GxhI7GDbwX8x+qo79L16NE2T+kIJdL93+Sb7JAOVszt2HCWAfzJKqmcAtKx0T1DQaCi6ixqbm4x2Wt2ipd7vWghV/al0pTzY/nUOfeTmtCYLWAJjrjZd4n0Jdq/wy9aavXxuQoiJ3YDsX+v5sndCdtx4Dq6f8vlY5DuUT7Z5wNenPckmgQ3dn577M0RR7WZXkVbKDWPYgjJPt0PwaH4u/R0UmFS4tRGPMFO+T0TdYDwnH9fOTeLiaAMuY7GGMxy9XYh90H8xXfhX5tIjSe0/DqBlTh1Dbot9tvU9/vzly78rU+yVEFUuq/pYwqSAVEygnaZPNX26xWhOiaMLu6KW/ov6A6zrylbzmvlTpDIdcEDLPWF64dcE0g0tMZPJfzH5Xsm5XKHUvJcxjxxps3wpnDJive/eUWiqANSkdGlfVOGsGJ5FAp7bixsRHc1oR3VpKD//1ixV2UK4iapF1uotVZEzX2e0z35PIeaxc/qdWx4G4jlw9RWYOI8gXtdMkWRy23ELQ4pUrrvtmsbr/WBXHlq43SZsSwa9ViqyMEvynsqzdrFxSAvDMxAxckMhE0Ggrz/xuA/6aquANo9Cl2Ic2UoT0LQUoIxYH05Wq5AEoTLpVvGoeqXwAmfdLQaieDDzeQe3RtQKnIOjxW1c/w==
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:Postix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(23010399003)(36860700016)(261009223027099003)(18002099003)(261026121527099003)(11063799006)(10067099003)(261102123227099003)(261021121427099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: lfXNly7hk89nbD9UWQt2BQ8e+VcRULQgwMoyz1NlnPlGgMhWjr/rgwDdY0tNNXAzAHfqjGk9Mur2z3DHodFyYIKqTrMSqBSh3V3tNNDanMJQtjS12FnG2F2QVGXgIc7+W24/7O9IX47rh7dFOsH6HYZWd0//8OfFcTSAZql0QjdifUQp8rNLWhy2B9NIMFu6TNwQf8TzcSkxT+IAnLP/KwgXaGt5BwXDBJjBXypO4Dd1QMyVM/xddPuefks2YaCNSJfM+yuPpvSD6fGYROtsN9HDEK6vibVjM1KuFmXe60Z4plFsoCQaA5avjCy9SEp7AAQ02ybhlUCBS0NI/kkPtpbGwZ7swxlNMtVtucCr+ipjkHNpL+kTWTvJTPi8gH1orXxhyrdkPGm2Gj5rNreWTVQKUOo7OEHUL0LxfHoy9sOwBl4SQbKJ2gX7Q7C8vUWF
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2026 02:04:32.3254 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 88b90b3d-1497-4ed8-1b02-08df41f39fcc
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Postix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: AMS1EPF0000009D.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PPFBBC768893
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add guard for PHYCORE_AM62X_RAM_SIZE_FIX to hide it from all the other AM62
configs.

Signed-off-by: Dominik Haller <d.haller@phytec.de>
---
 board/phytec/phycore_am62x/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/board/phytec/phycore_am62x/Kconfig b/board/phytec/phycore_am62x/Kconfig
index feacc3d6d402..0e8009eb118f 100644
--- a/board/phytec/phycore_am62x/Kconfig
+++ b/board/phytec/phycore_am62x/Kconfig
@@ -39,6 +39,7 @@ endif
 
 config PHYCORE_AM62X_RAM_SIZE_FIX
 	bool "Set phyCORE-AM62x RAM size fix instead of detecting"
+	depends on TARGET_PHYCORE_AM62X_R5
 	default false
 	help
 	  RAM size is automatic being detected with the help of
-- 
2.43.0

