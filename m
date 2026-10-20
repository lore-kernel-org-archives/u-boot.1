Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C8E606A31C
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 14:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=nNmmauIh;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=on/A2R8j
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 01F3F6076C;
	Tue, 20 Oct 2026 14:00:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TH2FUed0Kv0j; Tue, 20 Oct 2026 14:00:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 5B9C8607ED
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1792504841;
	b=F2/1pJtwAjh5v0EeA2DaoEw9bbbNHQkjSYTFm8lTb0MPrZEArfkNtCjMqkUSnfsmyXy5
	 fXrC13PsWMMtqZCxYGmAT5IMX9grsPCGsxMOMFAIs3EQSB/fDLFHMvuNfFW9JIxEfIiZA
	 ZTgvG0m3kPTYw/2UKSJpafgrzv5NutWyPJ92vz3CnWAZExiHIkU7P+hwD6GOCOFsb79Ob
	 l7Lxp7LS2/85weqxvbIDwyhUXn1l4QDGb71LJmOtqN/wCheDydUdlNPjgCBpaqZ2I6aQf
	 F8NDRt0vIUIFkKnmvXmkezXnylKu31aB+mHiHr8CXDEF7FbQKDBCzUSsHYv3nstHNhw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792504841;
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
	bh=c07qfK5r2/jRsVtTyCZ7G21iP1Q3MmGfxm4rqVCf5fU=;
	b=VTYuqQtROShtuDcz6RDtg7cjoLWMycBVIIARpmZvQPY8tZfk65OPaqAQiuB31BVPmAB1
	 h1Op2K25hEL8uurb8v8jHenAdGb9qxzipdfAoFNClojXG3UczPBoSrubi+KRMMl5c8+kk
	 TTS3fCozVgZX72VowrnnZ6LJ5Eg9hmIZe4jY3wlXUF+AqPMf0GcVsoGzeO1FZeqVy3+sr
	 mxcpnIe3L6NoNzMoy0ikKZqQ33BrtfckJEooKqj8goNjIWxuatqmlPUoGWnpTZqPGhRpH
	 sg73RRVDZ16aIQB37jq57EKIEnAVu8QkxiKvOOlFPEWCA6ABWYkdvek+fFO8iOfBUWQ==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792504841;
	bh=c07qfK5r2/jRsVtTyCZ7G21iP1Q3MmGfxm4rqVCf5fU=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nNmmauIh1/lbRW2c4Qq6+BCE342nBLNkfCapv0TBD4/uXfEnHo1Ej+GdzeuhF6DDK
	 njdp/xY7/MeLLVkAyYPuhcy4T6gZP0BpzXTLa/VHY0459PLRKs9CwHEciUNVdpcdPE
	 Y6LI5U+/IK8tYIB+Q+l+3fxDwFoBb4AakACEIvHq1Cn8ib4XLMZ607YghCd0rGemXk
	 d/GvpWLzFyZR3OwfooVVvrMkQ5PpZ/htqULGkMF8ujqFu4FzAXyROg6Vafs9yLvJoO
	 kBFbbJVAaduoiqrzUTtmpwNlkpPJ94wv6kosGfFlylwWbaHg+9NrBwd0GmovS5KqOM
	 OKcfTUjC5XIig==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5B9C8607ED;
	Tue, 20 Oct 2026 14:00:41 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 0A91B255
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 14:00:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E1DA840359
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 14:00:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PdTMasCzwk6B for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 14:00:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 0EF494034F
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c111::9"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792504839;
 b=E2cd4W+2cr8NkvG6GXiogUJpSXql0tOnoALMy//W9kGP53mRZB3k48XiTdLtCaeKjP4I
 1pHQN1pu0RNgGW1T+x5PnxsXR4r012IEGd41ej0rqkc5+vF02eN/NhR5vyGUBc3/eGrJl
 lWgPxtzRaL6GHn4qCkNP/YtJg6U5yPDlCQqetf4799VjE4pVhLrW0YQmi7jhSqQgH2byP
 fCRVwTEa7IBtXAllcbyFq7vjaPKIJlwkcmNEp0kQ0BlWAnP7JlOcGoWXlexrfE1BfyPgj
 DmXcbySwqCM/ib1x4isjMheQ7E6MFc5hPBbbmMc1x46/qx+WMogZQpLsO9g1Fu5I/RQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792504839;
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
 bh=c07qfK5r2/jRsVtTyCZ7G21iP1Q3MmGfxm4rqVCf5fU=;
 b=Gx0rIJ0MR2fHkIHf/WLp/GC8HJkSBpKLuKr2G+Ny2usQ1/8DyxMYO39LUVwwvbtRnLRK
 k8rj7abXJ+MShiibqjaQgCfEkc9mTQaoi5GyQreXNpunMeDxiiW9zf9dfmfdQzboJDsY9
 iuEfi5zAWl/8jZ9yBvkC9Fg6Kde2vxbVRrQhradA0A2iplZi7V5rA8KuClcZggAT8P33h
 jPISv4CSB+bGu2CmcaFFPCk/MHdIPGGVbQLO5BVMcoNd29T1wuf7+WWrze9j/O74w73ZO
 6YA4GQD32AumhJWiuXouDuSrPeFniwtD5GqRaBBvY5onYlEpZ99XfiH4xzRtW8uhpTA==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=amd.com;
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b="on/A2R8j"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c111::9"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c111::9;
 helo=dm5pr21cu001.outbound.protection.outlook.com;
 envelope-from=michal.simek@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=on/A2R8j
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazlp170110009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::9])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0EF494034F
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 14:00:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p5TMWGng8J3fzHQ14phKGBV2wm8iLd4ouz/t0V/4VUoSTlkxtlUOzQbax3BKvXKOZfuhXPh4TqJa8Wv17NtXntpMcYJyok/apMKvHD64pi8f+1eG+5U0cCI/nKmnWOCEK8McbQrMbZ8KaqWzm9YJhqFeDGi6iy4el7LVpqlr+DLNNQyWK9AmRNO233kvp0X6Yvp7vLKwNMGCu3SDT0T6RezFKO5Us8jZTJO+40k6udIYl6L3C+tsK9bXPw68tVpLJ8k1sWrruTWjTCqc70mGc3ooqQqSEaV+Q+QRCYMuNvp5E+wR6mPfQ4WnJtFbgTmnfoSPHJ7cOpIX582RTOMfbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c07qfK5r2/jRsVtTyCZ7G21iP1Q3MmGfxm4rqVCf5fU=;
 b=lIEFBYJcxFuzJEPJC4f8oWN6MPejetq9PWn+Hdm4Mv5nGeckqWk+AkrG63nDdefuo33p3K36BUaQcdgq8yckY2Bai/k2ahtWDV91K5Eq6WyNk+Oa5ZHeon6bfPUfAWv40WTjAiHxnwcQ4L7XUNKt5pI6nVWtb6CQKBpqIVc9zDziM9klT2oX0+0LItyvJtErL5zSINsT3ZKKw50NA7TombUQyg63O1gw6+0lhhgdvcsZMBB4/N6XQSAvWIT243QhLeX5JG1DXuvj9ysa0NURoTRNePxP5zK+8/8hpuxWbzeJwG2RrYCNL8mngT3WkeIeaqlwzSvjBnu2AbLXBVMfGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c07qfK5r2/jRsVtTyCZ7G21iP1Q3MmGfxm4rqVCf5fU=;
 b=on/A2R8jyoar5Gv8+tLaUAGy1XYeM5Wf7ekqo/xVQr245ucCOenbl9B8xrhLKHdNxafl2XzeIzjScn4s8W1q29YPCfSfZ0GFvYp6a4cWQ8/0dj09NvIut3mUAlqnynQAwqGLhVh5ftEBJTc9vZWsr2+nJFZy4gT3Qb/U0I7PnaY=
Received: from BN9PR03CA0919.namprd03.prod.outlook.com (2603:10b6:408:107::24)
 by IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Tue, 20 Oct
 2026 13:59:33 +0000
Received: from BN3PEPF00022BD9.namprd03.prod.outlook.com
 (2603:10b6:408:107:cafe::49) by BN9PR03CA0919.outlook.office365.com
 (2603:10b6:408:107::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Tue, 20
 Oct 2026 13:59:33 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN3PEPF00022BD9.mail.protection.outlook.com (10.167.248.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Tue, 20 Oct 2026 13:59:33 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 20 Oct
 2026 08:59:30 -0500
Received: from localhost (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53 via Frontend
 Transport; Tue, 20 Oct 2026 08:59:29 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.u-boot-project.org>, <git@amd.com>
CC: Senthil Nathan Thangaraj <senthilnathan.thangaraj@amd.com>, "Padmarao
 Begari" <padmarao.begari@amd.com>, Pranav Sanwal <pranav.sanwal@amd.com>,
 Prasad Kummari <prasad.kummari@amd.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 1/2] amd: versal2: Enable SCMI power domain support
Date: Tue, 20 Oct 2026 15:59:19 +0200
Message-ID: <cedadce6eb3bb9d0f633d8e2905e7848f14f5e02.1792504756.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1792504756.git.michal.simek@amd.com>
References: <cover.1792504756.git.michal.simek@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=816; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=4pYvYRSEGPDtCCOa7/BucgNS6nIk+ESiRq1hAJYCLjc=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWRdL97N83XVpBbBmwdkjPdZdb6Vf3JKcu2BQ8F2mRNM2
 G5HFa+U7ihlYRDjYJAVU2SZzqTjsObbtaViyyPzYeawMoEMYeDiFICJvMphZGg8IjMx5IPSlKzE
 Ownn362/yZvOdu26x7nbeyU5ZJMmXr/C8FfOsd2B7+TM3batdlL77p3Xm/DpvvjxOg2Bq6YXvTX
 NBZkB
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BD9:EE_|IA0PR12MB8374:EE_
X-MS-Office365-Filtering-Correlation-Id: e44a906b-a609-40c6-d8de-08df2eb25ec5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|23010399003|36860700016|1800799024|18002099003|22082099003|10067099003|3023799007|261009223027099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 8zxY0UZPV3A4ul3rE/ZCOd62IulOvLy/UlOkzgu0pmiQ4F+0Wh8T9wDW1syrWQyCDJZ54iczz6vuNnJsIxBCKoKsIi+K9nHcY4i6L76v0UtSiCjp7YWkZO31VY9nOJDrj5uRKhJ1bSouKjq4TshkpXR6BNISpGMvXEJFg2m3wN7AXUD5tE0bEBm2h4poNHQKsfgnvCCRAVyo2Kqn7udV1VREqr5pmSV/EMJz/bEA0K3SEVcvqmf34zsgUP0j2ZPrR8LAmhBaKX+V+JJ8jne4YfCKakGD8vd9KYZP/1zcriQjlfbBikSOVOf2ggiJ5mVDn5oTJ+H9CUXnh/UJkaeX8mCK199413h7Iaixu/PxKdRdJPG6Ay/U4QFbHANzYtdRVvLkOLDOiBQ7AkQayqGtd8zfht5IxOUOBBjPkWJ6im2a6/9JZJF9K/I69ivM/tciMKOHsXL/FcpRC60+KUEGnMFs1aMLr949M4skSsxkWzrV8BHSrqpE5qNynyUiX4NgxxszUeSFfUnWQ9JV+cRAdk+rSNu0U+Ph95w5quDyiuiae3hE/4fpSa6I1lti1Oel65uWHnMm5lFKvVfOblT/0WtnOFS+fwNSe9a0MfGpH0qyYjF8GdHnbViUtMgIqWyORCWFdJWbwJ66t2dTvtk4V/B0DtGmw44UCp9bpcx+0hB8BQ/vEvxXP85SNUJMBew+/h1KmZC0ivclDj2Q6sa8tA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(23010399003)(36860700016)(1800799024)(18002099003)(22082099003)(10067099003)(3023799007)(261009223027099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ODCMRlGhs7zTokEHFtAsutS0GMVOVTjRIxvxjeqQcH8Vu4pOJtkxobOLelMX2QhqoXbMT5L7HQj0lnvhdDnzpEEtAkU+wwlv/AtxWgGCnXpqs5/8FSeQ23ygVApoc/ovUPA/bKmqbEekVQtCunFhRLxHGMKuPRbp3gAadv77DXmlupfbLsqf1Ni/BYUDnAoTEWXXFtlLojVIO+Xp7ssFw3BY3WwScrlo8XPiXigJdYDFJkFK2x7D5ScyOHPDMhHV5zvSgCbbsaOuV02khnJGIorLeqtdYRlFgi205sxdTAyUNzrLXPZaGW93fsUoWl66TB0WqF/nF2qNq4X/X1vgrBHwq21O1bpZZfkKSAgJ6WALebI1ns5ykETKRdO8+Vm41XtG9y1boJn1VVqvTNKdxRXD+AA31z4HiLlq57hK1n4JNS6oa8glVligZgrQAQlq
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 13:59:33.8578 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e44a906b-a609-40c6-d8de-08df2eb25ec5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF00022BD9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8374
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
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Senthil Nathan Thangaraj <senthilnathan.thangaraj@amd.com>

Enable CONFIG_SCMI_POWER_DOMAIN for AMD Versal Gen 2 platform
to support power domain management through
SCMI (System Control and Management Interface) protocol.

Signed-off-by: Senthil Nathan Thangaraj <senthilnathan.thangaraj@amd.com>
Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 configs/amd_versal2_virt_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/amd_versal2_virt_defconfig b/configs/amd_versal2_virt_defconfig
index ea02b0c011bb..0d92313d6b00 100644
--- a/configs/amd_versal2_virt_defconfig
+++ b/configs/amd_versal2_virt_defconfig
@@ -144,6 +144,7 @@ CONFIG_PHY_FIXED=y
 CONFIG_NVME_PCI=y
 CONFIG_PCIE_DW_AMD=y
 CONFIG_POWER_DOMAIN=y
+CONFIG_SCMI_POWER_DOMAIN=y
 CONFIG_ZYNQMP_POWER_DOMAIN=y
 CONFIG_RESET_SCMI=y
 CONFIG_RESET_ZYNQMP=y
-- 
2.43.0

