Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47593606A31F
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 13:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ZR1cqU3c;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Y1VU47lY
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1F98940835;
	Tue, 20 Oct 2026 13:45:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1Sgehsxr1pZ9; Tue, 20 Oct 2026 13:45:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 47856407C9
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1792503931;
	b=nHhflB4UrBpxjaNeUPU535s2p9gY0NLHmVaMCbAv0qF/28lVpdV3BygReWTlUzJu78Z6
	 QRJf7mq+FEPHYiTaCHn+6flLce3bNUH8KxYyzwl3EWD1nO8i2RU8MRLC+2nKVZRphCHCR
	 os0zE+Jw2zJmHtijwbRoqCMAOFdTQmA3/fwiahAKROdWjSdTGJxnQ4yufHU6psyJl/h/j
	 a00jHOE1NTwVUAGc8f2ttLEWrNqw766Q7KrWCyqggaoQ4YohZe36MixK9W0RS7ZuDu/Gx
	 6HCy8ChTrR3SLZwsIoJGfgS5g4Tryg0tg877yeanAx8pNvoL5RFsES8dz1DWGGrt9uw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792503931;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 X-Developer-Signature:X-Developer-Key:Content-Transfer-Encoding:
	 Content-Type:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
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
	bh=lEWGmoYTcUeCJ360Jn+XSflP6naVaUoP9nlSfF1iwh8=;
	b=UNW1AgLh/C7TlwSn7lt28jETNsFgnsPv+krMLXUXIgRZ0OqmW1Cc+b0dzdbwHdUxBeyG
	 zexG2kExioU098IrOyd7FQzP0h7syqiddpggMos53m2CfEStKf6ENqEW7eIeOXGxnh/Nx
	 qcvWMg9+5AGUXbmf8wipFVxAC5e2aIsxSToeCE9g1SBDFP6q7CCZl0Iu6s5gb1nkAI2ED
	 0QDXEY/Z38gvN5Zbvl/bOY7M4q678uX47bNfdHMHDxtJ2hngd3grVKeeiXu8iul2HlHYM
	 stKopnY0xpFB/+wGbkw10IzFHdjpLTOxBdUSLIsAP4PXADKaMveE3pS7gtkcAZhy7yQ==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	dmarc=pass header.from=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Y1VU47lY;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792503931;
	bh=lEWGmoYTcUeCJ360Jn+XSflP6naVaUoP9nlSfF1iwh8=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZR1cqU3c5xcf3lvkYMHapBaysNR/i+GcDI4Fzm/oTXIp76SR4xVJlXe+5swBYs0Bp
	 KO41i4I8Kk1Xgdxmes5t9HqPWoGAneUVLTSHa2avmjFhT/IZ+L3zIQl++WRS24hGr/
	 VAtzV6onAI85KZJGUUhjHOfQIDl6x9j2AHPXUTAztfhNDVuCWJ7wJcYYfONom8Wpne
	 xwlkCvFLZC+Illhsz0MxXO9r96Vfd4lUvM3SXfSkD824phudVOcc1TLq2c3ryxhOlE
	 jeR2q+5wf4FJoeGjgzI+RxB/YKTPwifgr4h2CJ/KnX1AV3HqDH1rcRkHGOVvQKl71T
	 VNYIe4YdBNGjg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 47856407C9;
	Tue, 20 Oct 2026 13:45:31 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 949F9769
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 13:45:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 86450407C9
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 13:45:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GmiwIW7Qbh5Q for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 13:45:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 9F29640709
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c110::3"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792503929;
 b=V5OJ7xm6NCtnY8V0B3pT45VBS9s8BiXI7ZJGOHBEjXvqClvlVaUd0UE5AeAUOtnREf3F
 Gpmicziiytu06P5Td/MIC6VKolOl/T5J5pRP1mEGiTnDrl31d9//t1AnBWw2vmE/3Sxvc
 s0B1cA85MRBj8Hh2T46B4nb2MA37NJkG+BCapbc0lqUdqwivwjT3cnKpkYJpIivjAmhIQ
 TyJI/Xc0Tzbizicpv7PzzeU2xCbyhiJkkszujJ88MUJHy6j9gy83AB9S61WcpijUm4QWi
 hOXppJe9pAoSE9HERvy8yIkVvA2Hg2CuCEqsG5TnMfzawO84ytFUnTZW+5i8bSGyZCg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792503929;
 h=Received-SPF:DKIM-Signature:Received:Received:
 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
 Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
 References:MIME-Version:X-Developer-Signature:X-Developer-Key:
 Content-Transfer-Encoding:Content-Type:X-EOPAttributedMessage:
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
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=lEWGmoYTcUeCJ360Jn+XSflP6naVaUoP9nlSfF1iwh8=;
 b=Pyap7bYCqV6Q2gcUahFVHFb9jtavoarWaFWbGyqoWndoGbXeJh2d5zTtyhNUkLTlb/AL
 FYFrjrfDxALoNkfuWzWMG//YKpNkywzU+YSwkUNHgRSonhobbfSgtGpxgTrKdy16gBqwp
 fPn4+Yq4AeMSHjCZYE5S1Mn0GB1g7zqVjw34Rfo/s/FhqekGimYOgDcEX3QW3MOpQonwD
 9/mB5a646ooJojzpIH/4Gl0ku9XAsVnSZHjdstl8YOPeSupU88L0UXfHA5Gpu4cQZWKyg
 X5DAsgM71jftZi3SIfKzfoOplRFByzobpC6YoqMP2Fp6DKKTahbrBQInMnfipMW5Dfg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=amd.com;
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=Y1VU47lY; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c110::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c110::3;
 helo=bn8pr05cu002.outbound.protection.outlook.com;
 envelope-from=michal.simek@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=Y1VU47lY
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::3])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9F29640709
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 13:45:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TKWAQVt+FzcX0hJkD9wTCTbRStkgeecIReDu+SagSn6YpVcp6Xw5zsogcgZ0IiijmCNVTSbkIq+VTL2Ma8IuvVuRJjuD4TA8l8tyO8nVw5Sigf76jUZkCN7aLiF+7zZAJM3Vd56BKeb7x5q4b/XgPftZcrWN3MIpDItPHPqsEe9eYasRLOz6wx+9Cjy/Iw440pSu/KVel3f1x/wLwCUV0ieBbveP8Gj4MpALdPBK0z6BqFEpC8582BxIUHaeBolYS/mImKSGuK0Eb/yoZJdr4e9Igx1qrw4IGVkx7LFOQDb9vEuAaY7WygS4BVq6+LEojTr/JSQ3403sY1TVgmpFlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lEWGmoYTcUeCJ360Jn+XSflP6naVaUoP9nlSfF1iwh8=;
 b=g3ADAyr5eAV+zB26C44Q132tOM8z3OWWIHKzvD02IB2vTN+S6Po0JiWbd/FZ2yU8Zcvls40XOhtEemIgE9iDKw9Vd8RD1PcbQCel12CDsPJLzPgpp4kcvjdNo0Vr9qlH8ZhryA200Xw2UEQUVHKtp+zy9AFTJJBKuLqAhmPOnNgqAvgwtggXQwn7A/3Rnvaq4KYScEAXtrLdhr8k0LDc05Yy7dFnVYHd5sXbMCwHLLAQCAFat1Wc1KHY3AQlnmi+O6oJenG5dxFY/OnYXOyWwaSUhzLJIneNt+C33KzcaC2UbMLcBaddJAJov3wget5jJJ3MkW1IaFahH6u1IgOK/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lEWGmoYTcUeCJ360Jn+XSflP6naVaUoP9nlSfF1iwh8=;
 b=Y1VU47lYUgfp3SX/JHNFUFNVUe4k7+dHvFhhpweFnbZJ0MZkypApEEsHGsKE+SMBGAVrG4eoPnrP5JcQ0Dix/gM6kBgxv4N2a3DGjGMRTI9Hhx3MLcKCr4j8Jt124j3x6FUVpgD5aEs55COTsuUb3ikEFx3WPgGCzZDpKmAGfDU=
Received: from CH0PR03CA0215.namprd03.prod.outlook.com (2603:10b6:610:e7::10)
 by IA3PR12MB499095.namprd12.prod.outlook.com (2603:10b6:208:711::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Tue, 20 Oct
 2026 13:45:22 +0000
Received: from DM3PEPF000265B7.namprd04.prod.outlook.com
 (2603:10b6:610:e7:cafe::8) by CH0PR03CA0215.outlook.office365.com
 (2603:10b6:610:e7::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.20 via Frontend Transport; Tue,
 20 Oct 2026 13:45:21 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DM3PEPF000265B7.mail.protection.outlook.com (10.167.23.244) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Tue, 20 Oct 2026 13:45:21 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 20 Oct
 2026 08:45:14 -0500
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53 via Frontend
 Transport; Tue, 20 Oct 2026 08:45:12 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.u-boot-project.org>, <git@amd.com>
CC: Pranav Tilak <pranav.vinaytilak@amd.com>, Siva Durga Prasad Paladugu
 <siva.durga.prasad.paladugu@amd.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 2/3] xilinx: fru: Fix wrong argv index in do_fru_capture()
 addr check
Date: Tue, 20 Oct 2026 15:44:47 +0200
Message-ID: <76d6c0517595b128067aec06db1c6958fba1ad66.1792503883.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1792503883.git.michal.simek@amd.com>
References: <cover.1792503883.git.michal.simek@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1030; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=yIzdaCh3RPzdGMCQo8fzkjgkuePpz7NPRp8SrvbaWCg=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWRdLwjRDQ2+uNXp3/6S5zG3vmWwTTvfXfRu6tXJoRYr6
 vz6QvJZO0pZGMQ4GGTFFFmmM+k4rPl2banY8sh8mDmsTCBDGLg4BWAii9oY/gr0fA/hCJmkl7xt
 mdY972XrJ8+qTn+2iaPOZ9X+lTIz7SQZGTbX63QnMKzjPNx8b98CjVm2c9NmVF5XvnqRvSxPoii
 4kB0A
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PEPF000265B7:EE_|IA3PR12MB499095:EE_
X-MS-Office365-Filtering-Correlation-Id: 666a4b07-33f2-4c0e-074a-08df2eb062c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|36860700016|82310400026|376014|10067099003|22082099003|18002099003|3023799007|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: syl3wrUyt/o/a5FXY8cgWt3U1vXMxQrGQzGA8uXLIE90lezzmyLo/IyCNFQQrwRJVxXg/eKdeAeELkG2+XSX8/Jnp46I2qd9N7QXx/JWmIVM5O9Gfxhnr7T3ywTQSX7P/Ihge0Y8Nsa+NPhlvIs3+kWItVJYQqUyT1yXUg+jbU0Yd/mkDSu9nJSL5e0vrq1t9RBzb6hzjEAJK+v46PdYM/fEr+CFu0pYYd7GrVz+9JGFGGS0+iudlaWNJw/ukAG1StHf+EscWP4DXXZPfsv2VOxnIYJZDAWEzuQgnoEqoAOHx8iWKOrMc1W9Vtnfhrs79AvZsympJA9S3zXaUHNmp4wfaxeDak9GU+K1BQMHUjFgCwplYyKaj2g/n0WlOkMLIucKiUoPDtc+ZNPvljm8545CpETBTHQHGGL8dpVb09y+ji+7tYd31jjb3k5FbCV8Q65MwwJNyQQ7SSr/4C+X+dAx58zCd0LODlApj56g3HgWrsly/uYNWgAkc3+whMbGtGe2dH9vA0alD8cMrPdGT+7nYVuAjMTAJ2iatI+qqBP426pHp8Zm8QNfS8/IVOYxhDTqxzXk32P3RZ1mlnmLkQuFgIUnyTAw3deOrBflvCBmsEgoBITL4mhnlQ2r4CO7F7oGi1x4pBcHvD+DXimZ28WGLLTZMuvWtFV5vraNVDbmSyjDXM/MFmdj2Dvst4nfxyORsyoVvg4Jlpt/Fl36ng==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(36860700016)(82310400026)(376014)(10067099003)(22082099003)(18002099003)(3023799007)(11063799006)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Xlc6h7Wv5/INjVh+JM+Q7BF3DTQg+LZTgu0V3YOsEZCTn8ExQY6cPzMLAJGYYQc/p3anu9VGQiq1b/nVvGEFCfJ/j2tMZjDdv3xn2xb1appVXEpg9lEIx5VG5q7RWG1yhfBjp2lQ8U/24ptVaGglOh3q91nIEr0UapCM4KSzlHcqAOLYbzoMtJqn7VbNVMbn4IFBmQ4XuXABGHZGbIZ/VgwdbT06J5giQJLEYhgEDL+vMxTkxWNvhQU4qATGnRe7SdJWUbcEZlsrpnkKZIEBKUNUdckVPso93x9fq/PvQqBBRWkuZGIKo7YJJPd8olHOuzKK1v4IWVmj1O/V3NYXi/RiRT+/hT8w5g8FEqHKAke6ge37z8VgkNYhJLPEdB0hx7Lk9nwPzOuTAJsR2hBdFh/7ig1SIaKVHNfB06UcmG1tce8cc3KbePspL08sQ8PS
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 13:45:21.5468 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 666a4b07-33f2-4c0e-074a-08df2eb062c3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3PEPF000265B7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR12MB499095
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Pranav Tilak <pranav.vinaytilak@amd.com>

do_fru_capture() parses the address from argv[2] but validates
emptiness against argv[1], which is always the literal "capture"
subcommand token and can never be empty. An empty address string
passed as argv[2] is never rejected.

Check argv[2] instead, matching what was actually parsed.

Fixes: f1b97b5f18a8 ("xilinx: cmd: Add support for FRU commands")
Signed-off-by: Pranav Tilak <pranav.vinaytilak@amd.com>
Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 board/xilinx/common/fru.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/board/xilinx/common/fru.c b/board/xilinx/common/fru.c
index de165c548592..7566d961af1e 100644
--- a/board/xilinx/common/fru.c
+++ b/board/xilinx/common/fru.c
@@ -20,7 +20,7 @@ static int do_fru_capture(struct cmd_tbl *cmdtp, int flag, int argc,
 		return CMD_RET_USAGE;
 
 	addr = hextoul(argv[2], &endp);
-	if (*argv[1] == 0 || *endp != 0)
+	if (*argv[2] == 0 || *endp != 0)
 		return -1;
 
 	size = hextoul(argv[3], &endp);
-- 
2.43.0

