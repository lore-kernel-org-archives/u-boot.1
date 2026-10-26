Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B551606A31D
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 13:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=c5A9xem4;
	dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=HfOs9SYj;
	dkim=pass (1024-bit key, unprotected) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=dTCs2yng
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DD468405EE;
	Mon, 26 Oct 2026 13:49:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MhTYHImaeuIN; Mon, 26 Oct 2026 13:49:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org E9BC8405B0
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793022578;
	b=lZvGTrReCOKa41fJ63bwdynD4dcVaAAP4OCn8CzMTe/f+JmKXEWz0HOsEKAasDoNxx45
	 HrQbwFgV0hsexCserJJ1wCJVZ//7vxMOzIWVQUA4YwEaDJ4gJT8UGChAhsOw3946hZo7j
	 RDKayV1dU8bcgeRHEOaqzKZShoRv+0K7oR658u62RJwxiLazK6EtpyGGSdiB9dmayxiJv
	 7qudK236kQdO53tIB4SNSpV8KKvQzwUbXn+foWLsRYFZ3kAkxGumbbHfHS0At/TKfjy04
	 7fd5aGu6bQjCkU7vlY3oyCahM53PQ1D5SaAd4i/R4xjSwhDQZmiYi0wmd4GCS4F521g==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793022578;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:Received:From:To:CC:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:Content-Type:
	 X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-OriginatorOrg:X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=COL47iQKcYrFxkY90Qgh9GIo9E+do/dv/6G6rmRV5BM=;
	b=d4+XYBvJzWLeK2Ah89Dj1a6UC7SZlcwB6+vCMyOuvVAYnElYMBnz08/deS31XfOm5RDi
	 D2EAiG0571XfVTy2m5nrVl8lNpPz8bYcC86/Z9vxCiUVOv8sjSkDq+2Hqx9Eiwqd5HdEW
	 wIYoqRG4CO9aZNlocriNxlPHXAPjKtu7+QLmkClmnKRFu+/iVN4A+2kMP/1PVgtJxZNU6
	 MRuSsmlnv6QJugHOqoDzad7df0awkm3KqPRZPH5KWrpgBRLsS04mCGYbO4j0uKHuzDqna
	 nrz4Bp2+ePdrBNdV5B+TCBkBvbq7hW32XPjfLU6WVDWpruCaWedjOud2YXCUxm9BArg==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793022578;
	bh=COL47iQKcYrFxkY90Qgh9GIo9E+do/dv/6G6rmRV5BM=;
	h=From:To:CC:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=c5A9xem404m52TTxk/oYl0A/+mGNPbvgeDtTwkcqnOKv7Us/tDFvI3k1KH4j9w3UG
	 kNyZvXox1RUYSZ46Ji1+7tD6kYeH7tBGtpPPlbnm0+olbEuLY7jMSHWffmF3NL0k8D
	 ++vrezra05GY31p31C8L29mx9jkLNJGQHTPBllFZl8Sb+eb4V9NIsqFBo7Hf8mhs9X
	 xRrW3ovAy+K0cZMQgX/snerQql4iRN/t1k9AVH3pCIB/RhMdVcmy+AInDN5xMQyOwX
	 lPzzfrW55NRNiaqPBrz2vDGw3I2855qZ79729SuBy6JUee2Cm95FVD1jk3SIMGXyMW
	 7gCzhp+cN+P2w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E9BC8405B0;
	Mon, 26 Oct 2026 13:49:37 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 40E483B6
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 13:49:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 26EBB80D0B
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 13:49:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5t97PU7bVsgA for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 13:49:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 0CE9E80CF2
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=148.163.154.28
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793022575;
 b=KCjKjWUJDtTgEcPKjwpSfItaClu33gOsLeV1rfvigUyQAmSpX0Xxc8JAxA7P73/fUMEt
 GEu05XUyrf0rawNTW4mcRGNvx7PaRpFuLlXuyxagE8VOaBrVWfXNiuAf+PrkOaw/010Xj
 YXjhIsWqAX6lZKP88M7sO1q8StVmk/vR6flk0gglpzGJFunYZYQT5bGoaLrDn6TrZGG3W
 UQYb//gQNEIRcdPN5/1D9QbSD29Fzu1cDFLE4Sq6a1U5Hq/nDbxn2g1e6iQvgkxng3AlP
 4vXhARqG1VcIylFg8NFvNHx4h5u+0NV1sdwKDL8gUftnLvZMjKaOUHN5XoC2j7jHYPA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793022575;
 h=Received-SPF:Received:DKIM-Signature:Received:DKIM-Signature:
 Received:Received:X-MS-Exchange-Authentication-Results:Received-SPF:
 Received:Received:Received:Received:Received:From:To:CC:Subject:Date:
 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
 Content-Type:X-EOPAttributedMessage:X-MS-PublicTrafficType:
 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
 X-Forefront-Antispam-Report:
 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
 X-OriginatorOrg:X-MS-Exchange-CrossTenant-OriginalArrivalTime:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-Id:
 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-FromEntityHeader:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=COL47iQKcYrFxkY90Qgh9GIo9E+do/dv/6G6rmRV5BM=;
 b=TG0TH1ZARsu+ff13bP5LoL6iAmwbEXDTMIT743USHYhvSYYvxctmdLK31QeHaLPHcU6u
 pqStJBQuwkawTT2DKGFuXGNkPPa4zlwTmItJUrXv43jDbq6F9nfclow11dHRX9A5KOEzo
 2Tw4LGdH1KHTS2eqS8Iy+CDMhSiCnw3rMrezN8ZVO/BGZj4Su/o0kCnQAcaopaau5XfUk
 tvni1EdJ87/VBoCL0rVZJRcm9NllR6baqXlPP8xUjA6155w4KGhzjJO3rA/9ZiC/23Z1n
 WPmB7JM1S9s6iWTgnhNa4RUV4sLAKXFh08l5fidGsUUNtRqyyoFIbQhbujRhGGu+IOA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=ti.com;
 dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=HfOs9SYj; 
 dkim=pass header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com
 header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com
 header.b=dTCs2yng; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.154.28
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.154.28;
 helo=mx0b-0002e601.pphosted.com; envelope-from=b-padhi@ti.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com
 header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=HfOs9SYj; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ticloud.onmicrosoft.com
 header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-ticloud-onmicrosoft-com header.b=dTCs2yng
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0CE9E80CF2
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 13:49:31 +0000 (UTC)
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69QArM432490353; Mon, 26 Oct 2026 08:49:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=proofpoint-05-2026; bh=COL47iQKcYrFx
 kY90Qgh9GIo9E+do/dv/6G6rmRV5BM=; b=HfOs9SYjivP1CrFwZ2V3hLRBXCQMv
 WtZvjCwv/ZmUOyNdWUFNC497TJj/wS9HGDx4v0M0Y5/RiR7IiTGPrFV9BAu+4Rkl
 sC+9jR+62k6bWz3pXhlHmVQp+K4ZRX2Hn/zADHTGMWpFBlFjfd6kJYrFTkuNCi3u
 UzxofdFHHZRMdL8BFA/syHJs1m+RvgTj56EBcobZDTrYtZlNrMsBozAHvyjeeifD
 fF0Z4d/Uc6p0CsdCYeVTMMhCCbBYhk5B/r/rgxHVzDPkbB2V2tf03wqhm6DL7cRX
 XJwDqI07SBKidPvzUbSxkVosYgCnzRWsz08Fea6sngoxlwrx+3uKm/Zfw==
Received: from cy7pr03cu001.outbound.protection.outlook.com
 (mail-westcentralusazon11010009.outbound.protection.outlook.com
 [40.93.198.9])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4hj2g11v06-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 26 Oct 2026 08:49:29 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qdgrJ3mVa6k0ES+v7jD5WugUtP8G+4n6HvwKng47B55qR4czxWpTPNH9WcQ5lpexWH/AcysiN8jNfIKPWfkqUyQBICvSY0PqwPN4jS0xNcccUzHmWcT+X4lH3kXvQizz2/LvdTAuO5lm7sYeaE4UHTqfCKa+19VU1ReVyvkRqfiut3qyg7y3n+geBL/4gTpolWERDqWQjEuZSZ8YBQ61mbJF5OJW5RlmFuZd8ZFySvuHzmx0hGcEtMUhE7NC2j36/1D29lrPJhYnzyBjhN22+sjeCKiD9CVaA9vS5cYPFC1z4KJonl5pgwjCGhWhZWV4T3xki0JBcZuBDFyFc/HOOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=COL47iQKcYrFxkY90Qgh9GIo9E+do/dv/6G6rmRV5BM=;
 b=CQyVd9CS8fostQrM5joJ09RgRCUNpck9TS+CZp+lvC9z42NCR8YLtPpEsfxMpKayDyWgiWeDDIMHuPq12L88t7Z9o8cedMOBdzIQqg7+PZ4QULR5SF1VqmZuBcqyHHU4eJZkdD60P/wRGA1VW66TjjE05sAMvI/sKQ9vrDhFaY699HEzC3hQiIiIs5t+Uc425pS6jgfnji1Ij4LxsFYqK1K0DMx/0oQsQezlufhoDj6iQIxKLbAX2jzV14PnIcFX7SoPBy86A40LMGuadfrigWW9kjjVZKvXRIXTRJsVpGedd7eY9Jus4osOF1LpWPF1YWjJLfSxGl031uOFrr/nrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=ti.com; dmarc=pass (p=quarantine sp=none pct=100) action=none
 header.from=ti.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=COL47iQKcYrFxkY90Qgh9GIo9E+do/dv/6G6rmRV5BM=;
 b=dTCs2yng2aye1BDgJ6jzst3Uq3o5ygIywO81LOEpqEvlgZn9B8jH4D6xnrqMOLmT0TFrxF1Bz6+gaGyRhkzTgV9jl9GJUQrEIJZ7jefas7q6odZtgLam32wnZ9gjpYJA98uKwOkgSgmsOWNYMgNREF2YM+kdrgJ1B9yrYoq5Vv8=
Received: from IA1P220CA0024.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:464::12)
 by CO1PR10MB4433.namprd10.prod.outlook.com (2603:10b6:303:6e::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 13:49:24 +0000
Received: from IA0PEPF00000045.namprd04.prod.outlook.com
 (2603:10b6:208:464:cafe::6a) by IA1P220CA0024.outlook.office365.com
 (2603:10b6:208:464::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Mon,
 26 Oct 2026 13:49:23 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.21.195) smtp.mailfrom=ti.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 IA0PEPF00000045.mail.protection.outlook.com (10.167.249.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Mon, 26 Oct 2026 13:49:22 +0000
Received: from DFLE206.ent.ti.com (10.64.6.64) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 26 Oct
 2026 08:48:51 -0500
Received: from DFLE207.ent.ti.com (10.64.6.65) by DFLE206.ent.ti.com
 (10.64.6.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 26 Oct
 2026 08:48:51 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Mon, 26 Oct 2026 08:48:51 -0500
Received: from uda0510294.dhcp.ti.com (uda0510294.dhcp.ti.com [10.24.50.162])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id
 69QDmmcK4106899; Mon, 26 Oct 2026 08:48:49 -0500
From: Beleswar Padhi <b-padhi@ti.com>
To: <trini@konsulko.com>, <ilias.apalodimas@linaro.org>
CC: <afd@ti.com>, <u-kumar1@ti.com>, <b-padhi@ti.com>,
 <u-boot@lists.u-boot-project.org>
Subject: [PATCH] arm: omap: Hardcode control_status register for OMAP54xx
Date: Mon, 26 Oct 2026 19:18:48 +0530
Message-ID: <20261026134848.1733598-1-b-padhi@ti.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PEPF00000045:EE_|CO1PR10MB4433:EE_
X-MS-Office365-Filtering-Correlation-Id: ef756d65-4be0-49e6-2835-08df3367f0cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|1800799024|376014|36860700016|13003099007|56012099006|261021121427099003|261022115727099003|261022105027099003|261022075727099003|261009223027099003|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: T2nOtKyu2F+Se3Cxt/30xo5w92+4OnWHTGpSd0QXNtiTdfcm98bW0vSTVEokeFz/mLoq3rPPRYzOGYVrZxCYiAXVtQ4lDHiQTflVViwpSOkUT6A7VM/RszWLbNQOG26SOmGeYOFxysHtip0QvAskIGodC0ZL6j2rWK8x9YbFVVIOq1siArWE0Jgmokx1oAVghu2RnbZftMHXXtqdDKXN47xWLNk6gBE3XwITgQ2KkOBlQSYmjNRgSz+x5JQvJFpMIx1S6z4p6T0D6L7Bk8Dn1hpub8ppTa2EDZjLy5IUsMV5arD//OxtWLPsFN2Uu76XIbH6nORNc+tWzXxKaXdWkhaxrAxKj5HDMiA2MKhUzu6HSBSXCtu17vRA5H+qiJ+303iTQdmZeFSRrEwAGbjTI/6lMmJ84AUKEX942se+sEnnx2b+4F1ehwBsbOdtjjOoR/c9Q7mgxbeFupR3lxcsaxy8U/mUZGRM7D3lGauUwoGWdQHepbYAxslUT5jIIlAXR3tWzo0N4muQwk9m4i8uN6kEJbjajcNEE3g20Zt/N1P7xIMF0xQ0L+hm2EFE4yGXL3OafdelFrPU2lbHP0f6Vz4LmsclNLFPx/SBx0wJ3Gmuf7w3sfYpMImuxB6OcBdTW2o7XBVo66c/art1ALzZGjQ1vZRSyd4hY6hrbvYWtOMe19kJCkEh4cAGP6Ndt5lTG2dYMWIocO3IXjM7++gO1w==
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(1800799024)(376014)(36860700016)(13003099007)(56012099006)(261021121427099003)(261022115727099003)(261022105027099003)(261022075727099003)(261009223027099003)(10067099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: NlXsLe8P8H+Jp9sqZLGvUyOOmrBil1kxcPA+CFGl9T1cB+FZA67P8y608MWT46lZzk+U//FjacrlY8O9lrsX5swXgN6+8qsYQwzuWt8v94SqqJpyJklaxnP8TUR8milVQhBMFLN1riGa9RY7WDvdL8BZSQQMWk5pP38BvnwZ9EZRS/QUoGh17YI5Dt0rRzIhPDZ7W0UFo7ZyyHOk7fOPyWsMmo3UC9BMqllv6RX0t/Ugq/DfckDKpsBhXgIIGHorG5TsCd0M6CKQsRaUBKiclOK3ytyOqHC543yeAXMDgZTNXP4C8tIAg2bXAPPV8+nMq2OheHV8Im+xGFRGXX+5aKIV7O6fGmht/aXhYTBkICh6xvQlWgNBW3VBL+z/v2Nwf1oWREVoS8VHGO2IeHAIRfIRWiwZr7iS7l8hzzNmTwW/ugEtyYTPKMUci6tAKUFF
X-Exchange-RoutingPolicyChecked: Ulz7cWTHwJ6ljh4qhq4EDWDe9iAWSF680Vl21s7VpiF10HsorpcmlDpSFCMi8j3V9CLaif3H5Lt7v9XdHh+/nfOYUdBWko7+UIarS83h9cEGD9xPal3vy8zH0z+uDl28S9rtQeAwwuxBtqrmRj1DgqxG6fDz2fQKc/mHpRx9xY63vcz0tEsV5AMFVwOZJ5iQJNh6jSAg4CF9z4HYvfAZO1UEUx4WcaIjRwLIDORkPyLaxjcxTVc/WfvAFBBboCfGICE2FtHFgmlpcjsSfh8ZY3VIwDS6nTogiW7TaaZNabfjUa1akmPEvJ/BlSXg5jz8P9FI8eK4yfThLRS3ElwvfQ==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 13:49:22.3379 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef756d65-4be0-49e6-2835-08df3367f0cd
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: IA0PEPF00000045.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4433
X-Proofpoint-ORIG-GUID: fQb6ONMcm6R8-i0M3rCkOn5wfCHAX1bA
X-Proofpoint-GUID: fQb6ONMcm6R8-i0M3rCkOn5wfCHAX1bA
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDA1NCBTYWx0ZWRfX3YwgvIKumzBl
 Ne1h2RGpLx30HmmVjlcxuR25Uy3kLWdB7+pJjHDN+ig3qDgWYpKC+5YVYlB4hZjMdxkFurSt7KK
 kqpWfUtmh1GH+7sF5LUTOOai2dvTOrY=
X-Authority-Analysis: v=2.4 cv=buPZl0ai c=1 sm=1 tr=0 ts=6adf5a69 cx=c_pps
 a=MYJxclL+TLfs1lE1Gew55Q==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=660iZSQnnn4A:10 a=AlMIdn_sM9wA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=fPAWb5peG099m5CrUpKH:22
 a=NEAV23lmAAAA:8 a=sozttTNsAAAA:8 a=bklehDrZTqXZh4icIu0A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDA1NCBTYWx0ZWRfXw/lifaXUjMpn
 tC+M5vXEhwvCfMbeBD5jjTJswGAoyWheuL29mMz/ZmwwmFKNDB+8cvFRZrtpvKyCUwLtA96rkvj
 xB+8h9Q3Eqlli4so88KTPdYWb+laLKIn+/5UEO0KgjZvr3qBXasXqWKqYE6pFsqHRjnV8Ur4NsP
 HdCRk6WTLnfXPVH2pFmgbBF1ztndvM9KH9GWVauWQ+WqWmNCjPpt0hmrYVRaHN/Dn28WlSZS2wH
 TlaoRE7rnk+N0L02mm6R4D/XBGlF/MqIEq5L66ncPBAWVV7AY4EwUhcjg9CvUQRFTS2wySOrJVP
 NDL/w9/j6GSZxK24O0SyZ7w8/y2bFHDNkfeoxg1I0cS/hEbDIEGICNCI7ZQVWAO1ezIY+76ll0E
 KarzQA+V5Eax2ZrG6EeiUo6pS4S9GHaBQwUKj4Vyc0OgWBN3NJ7/7dFL5PuNAeHpB9qb58zoVkC
 aitAkmOmAzlcSq+GkrA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 impostorscore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0
 priorityscore=1501 adultscore=0 phishscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610260054
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-23.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Currently, the control status register address is obtained from the
ctrl global pointer which points to DDR address 0x8086XXXX. The kernel
section from the fitImage is loaded to address 0x80008000. So, a larger
kernel image (~8.4 MB) overwrites the value at the address (0x8086XXXX)
pointed by the ctrl pointer. This corrupts the (*ctrl) value and CPU
goes into a data abort when it tries to access the data at addr=(*ctrl)

data abort
pc : [<fff551d0>]          lr : [<fff54a41>]
reloc pc : [<808031d0>]    lr : [<80802a41>]
sp : fdf0cec8  ip : 00000020     fp : 00000000
r10: fff5366d  r9 : fdf31ec0     r8 : 00000000
r7 : fdf31fa0  r6 : fdf40363     r5 : fffe275c  r4 : 8ffc7000
r3 : 726ae0e1  r2 : fffebe40     r1 : fdf31fa0  r0 : 8ffc7000
Flags: nZcv  IRQs off  FIQs off  Mode SVC_32 (T)
Code: 4b04 681b 681b 681b (6818) f3bf
Resetting CPU ...
resetting ...

Fix this by hard-coding the address of the control status register and
avoid using pointers as done for OMAP3x case.

Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
---
Note:
Without this patch, a larger OS fitImage would cause boot failure on
OMAP54x devices.

Test logs:
https://gist.github.com/3V3RYONE/e093681fd30f5fb83b422efd9311c78c

 arch/arm/include/asm/arch-omap5/omap.h | 3 +++
 arch/arm/mach-omap2/sysinfo-common.c   | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/arch/arm/include/asm/arch-omap5/omap.h b/arch/arm/include/asm/arch-omap5/omap.h
index a9c0421b140..5791fd2d635 100644
--- a/arch/arm/include/asm/arch-omap5/omap.h
+++ b/arch/arm/include/asm/arch-omap5/omap.h
@@ -24,6 +24,9 @@
 #define OMAP54XX_L4_WKUP_BASE	0x4Ae00000
 #define OMAP54XX_L4_PER_BASE	0x48000000
 
+/* CONTROL */
+#define OMAP54XX_CTRL_BASE	(OMAP54XX_L4_CORE_BASE + 0x2000)
+
 /* CONTROL ID CODE */
 #define CONTROL_CORE_ID_CODE	0x4A002204
 #define CONTROL_WKUP_ID_CODE	0x4AE0C204
diff --git a/arch/arm/mach-omap2/sysinfo-common.c b/arch/arm/mach-omap2/sysinfo-common.c
index 49bc3a634fb..1b7bca3ee37 100644
--- a/arch/arm/mach-omap2/sysinfo-common.c
+++ b/arch/arm/mach-omap2/sysinfo-common.c
@@ -22,6 +22,9 @@ u32 get_device_type(void)
 	 */
 	return (readl(OMAP34XX_CTRL_BASE + 0x2f0) & DEVICE_TYPE_MASK) >>
 		DEVICE_TYPE_SHIFT;
+#elif defined(CONFIG_OMAP54XX)
+	return (readl(OMAP54XX_CTRL_BASE + 0x134) & DEVICE_TYPE_MASK) >>
+		DEVICE_TYPE_SHIFT;
 #else
 	return (readl((*ctrl)->control_status) & DEVICE_TYPE_MASK) >>
 		DEVICE_TYPE_SHIFT;
-- 
2.34.1

