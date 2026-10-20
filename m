Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F213606A326
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 14:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=sgytriqi;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=E+nvETCn
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 22C4C6084B;
	Tue, 20 Oct 2026 14:19:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rdAlRCuxL9L5; Tue, 20 Oct 2026 14:19:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 423AB6081E
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1792505969;
	b=Vm8ZPhmkLwVXSsbGPNi0SY60FBYvPr9r8u0YVNnRLMm/B6quUIzjeFBffgBSTUXpK978
	 uyllZKSFI8ZBh4VmIy69vqSQ0+ExK13g+d1XORqYRMQl/wB9jtBkBvNY4/eyRpj3yxUd3
	 euAbLeeJqwWMFcAisHy6j5MNZWrgrYBmYBaqini020RM+osI9/3jCiwLsb9VnvbvxPEHD
	 8N8VnYxYPQ96YQww0HJ6Vyx+FynHZ6m4xlndtzvJttb+8IhhqHuPntEIqHbG1TpB3ip5o
	 TdyGM/W2v7R8Qk23gx+BXG254mIGDZ11WP5m/wuQy7gxiZTWVHc8QKDtOHgaXxl7W6A==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792505969;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:Received:Received:From:To:CC:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:X-Developer-Signature:
	 X-Developer-Key:Content-Transfer-Encoding:Content-Type:
	 X-EOPAttributedMessage:X-MS-PublicTrafficType:
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
	bh=tOLrLjCqmFqC2OIgqe/eYhNs5pr0Kx3yDbVCtUjpUCc=;
	b=TUFMHOc3rHhSHmp7OjfBMxDDTx5UAELt36L3kezpMjYnX+FybgYCCYuKAJlszCVKNAgQ
	 JKauihDpBRvBnh9Zaw7ljeDrURi96hWAy0dJ4i5ATJYK0Nu7zuzqWsPV1fZoZPuVo6pH8
	 aYeEd0iG43U/5e31YklMM11AT7cN6tCIrwahf2MmE6BXuhEaZmrykVf2SWAt5kByDvRDm
	 lKhKd+WETffGpP2+iH5mm/8W8thi2DgrgIei2jp/kB2KmCX8mZwra0dKprZsov8XavA2p
	 bclUwD+//6ijfeVlH22HDq9P3LsV8lQWlYrPHyYfVZWFeXYNpYA1zM/57Qyrnl+VymA==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792505969;
	bh=tOLrLjCqmFqC2OIgqe/eYhNs5pr0Kx3yDbVCtUjpUCc=;
	h=From:To:CC:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=sgytriqitB1aDcQumPEeaB7yuffSt2KV6+H2SX6ShTat4yWsS4Kh9SL8L52iuXMeI
	 inoIfOH3mjEIyNS/GJ/vZJl5LTSvfqPnzUo6ybyrxeu9rtziF0PvgDq0t0FhuAP1yM
	 6Yxphyut0hgRK73tT+oFcap9Bya7l8zXPcmrbnZDdMwzUZmxPt+fAXUGGX5rHja4hg
	 xlq5fHmDyhd//bRn93zq070Jwk3JqYgaINo5YUF7FjqVTMJtSbiPYhunDxrWohVkwT
	 fQFT3p3jW4V22SbwjbOQj2uevgQbLQhBf3il5+Z5pCxpNdN80aZRl4q//QeXNZesLf
	 kAyB4Zod8Vnmw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 423AB6081E;
	Tue, 20 Oct 2026 14:19:29 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 460F512F
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 14:19:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2BE3240359
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 14:19:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id S7NV4UDdy4lv for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 14:19:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org B3D804034F
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c112::5"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792505967;
 b=rYhKXzAAmJveTXizTv7mGT6tQBcyGhhN2pTh5YVWEnVm1PRBvi2vHq2fFhaOzdpIXvVn
 HRDae4kW648XaWkpqrYplJoafkzK+xMc2W1n9gsS866qlceRN+NjDOSDp1jSe93vBVUB+
 WhqWzsPocgk4ynmdIJA6mKm7tJfvKEbzcGfERK3/eVL6VoNOgK9erge5l5k2tFujWMdfs
 cF65xwML5Y6hYUzDnXF4aGiRjKLv66LBIuWPjy3VbMSkkuRboqoQdsoOBNNS1JwZOuBBc
 afbO47/HJMs4I/ubyPC7L0qYJpBZDKPfKDCu05ZNqiK1CJ0MNqPoDH+Xtqb6Pp6flvg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792505967;
 h=Received-SPF:DKIM-Signature:Received:Received:
 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
 Received:Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:
 MIME-Version:X-Developer-Signature:X-Developer-Key:
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
 bh=tOLrLjCqmFqC2OIgqe/eYhNs5pr0Kx3yDbVCtUjpUCc=;
 b=DuPzhtxgjJp5yKlyux6uxalGzlWAjUq7eZNeyeb9GK0OkXJaO+xwxIbElHIqUEqUByHW
 7BeKyvgJ+sCs6ow7nHlxEi/4R53apHEdxdlzG7U6uVDJ1pWvbUj4qW4jabFCXgTRDRL/h
 GzEqu/muGnXQA0ovSMdBhQ7tKa07SYXAAYSZhFBD8ekBXbk3T2GmHBwYNAAxPDoOqiVri
 VqkP0SaID++WJc/nYxNYahiDm4yMbMk5AIGsPdNIzAdhd/GONoWHDZXzCKgEKtlQo4SUG
 qR13Bz8m18+uahuvBZRcAX5J9kmHseFPcxRBKfjhaSFwcBT2shGAkKKSYGYjnwPBCag==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=amd.com;
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=E+nvETCn; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c112::5"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c112::5;
 helo=cy7pr03cu001.outbound.protection.outlook.com;
 envelope-from=michal.simek@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=E+nvETCn
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::5])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B3D804034F
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 14:19:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Uh4E/E78vIKIojD1oEWBgYb7hh4PBdeTdjOxkBc+uuWhNeq7S9/dzUmkno0u8590zqM6JfvFaPr9H4ZH6Aa0VJ1dEKNiVH966+CwA1y8DBAaJs8b/Mk+7JkFRmTJE1kpRhUhvLrlWHBJV6wTxAYfG7Ahzd2voA4XQIrafZLY0BGizwJCCdikYEvevIJPEkQNoev5Qc7+OV2cSLoX5vnmQLyZRQn6jK4Qvolv09itTi9gTOPMa2o8hT4IjffxDlhBZusWZrqM69aPZKke/lbsoQO0mK38wsCoMeL0qUw7i3Tdb4NuerkdwbdUY3jfC1S48somL+ryBU6CVVjZY7OWzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tOLrLjCqmFqC2OIgqe/eYhNs5pr0Kx3yDbVCtUjpUCc=;
 b=r1oBhH9pNAAbhpZDST9zUVBOXc/Lo5FLUDGlWiA4FjFNdC0oX1ZQN1Wrw4mAUNlBVtgTQL/vQWqkL4ZFpvAsa3PMqgFQ0gehzkMEme2LIdTUIpOshoo06bpDPUnRGFEvj40BSFIFMw0LWBv3IsPmcNftpq01tU0x7Qa7r5ZNKuQGuCPgCQoMNugN7Dhj+r9EScSb74pzRV/1wdHLU4UiinzUJVtQbSV/Xt1T/FU4YHiX3d4MOeMGP+jQrZFsU6X/IJIN6j5k439uHeRx24fCHi0eN906bpJPye1TTJm8ZmjzrZLD6SYNO0GL+7gIqebcmLkwqMRxceWCR/DQ8tiPNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tOLrLjCqmFqC2OIgqe/eYhNs5pr0Kx3yDbVCtUjpUCc=;
 b=E+nvETCnZPlxiByTss4cz6xd72d1cVZZq52ET59m+j/FMkKUz18oExie77LaEt7vVZ9BoKCSVjsyTVYtwtF7IT4PHKSCNtww+NlPji8LTby59O3KTyZztjYQZTMeEufXG3dtuGy8vB3EWZO5GOkC5uke2lrkHFjhvs9gY0OmOM4=
Received: from BY3PR03CA0011.namprd03.prod.outlook.com (2603:10b6:a03:39a::16)
 by PH7PR12MB7137.namprd12.prod.outlook.com (2603:10b6:510:1ed::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Tue, 20 Oct
 2026 14:19:13 +0000
Received: from MW2PEPF0001467A.namprd04.prod.outlook.com
 (2603:10b6:a03:39a:cafe::8b) by BY3PR03CA0011.outlook.office365.com
 (2603:10b6:a03:39a::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.20 via Frontend Transport; Tue,
 20 Oct 2026 14:19:13 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MW2PEPF0001467A.mail.protection.outlook.com (10.167.249.187) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Tue, 20 Oct 2026 14:19:12 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 20 Oct
 2026 09:18:59 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 20 Oct
 2026 09:18:58 -0500
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53 via Frontend
 Transport; Tue, 20 Oct 2026 09:18:58 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.u-boot-project.org>, <git@amd.com>
CC: Mikko Rapeli <mikko.rapeli@linaro.org>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Shaikh Mohammed Suhan <suhan.sm@amd.com>, "Tom
 Rini" <trini@konsulko.com>, Tomas Melin <tomas.melin@vaisala.com>
Subject: [PATCH] arm64: dts: xilinx: drop bias-high-impedance on SDIO CD/WP
 pins
Date: Tue, 20 Oct 2026 16:18:45 +0200
Message-ID: <15d2705e0807fef7567df21ebcfe48aa7f1466dc.1792505922.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6750; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=06+nrSZsut66WdzW22m0VHTFwm7jNt+k4zlxBshZC+4=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWRdr/BinVfx+t+EPfFbTu7sl/1YmbfIfM2G2/OFPS8yx
 zeY6JXUdpSyMIhxMMiKKbJMZ9JxWPPt2lKx5ZH5MHNYmUCGMHBxCsBEDl5h+MPxk+fiQeEXju8N
 arLUzsULlwQpyD126LB//mHSw8VB8UsZ/oemqfzPmpV6p7YmUl/qTcbT0DsWYZ///flbaz/tbYC
 eAQ8A
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2PEPF0001467A:EE_|PH7PR12MB7137:EE_
X-MS-Office365-Filtering-Correlation-Id: b6518b67-2c57-454c-afe7-08df2eb51d9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|36860700016|1800799024|376014|6133799003|18002099003|10067099003|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: r3MGvv9uzUOYscvwPjRtVCJOTPLKuG2z0tZNdftCZRFUVsvtTsNLv6QHFWl+LlHmN0vfhjGG1+5rMbHm9MeWcMei01vpQpu4f9QG/7d43QSwvPrMSAaA2tAQQPR2/mU2QBq+oDXb8lBnWFOfSBVb+BaAI18LzpBbRFU2w5L97z7FEOZfP3dT7hjGAKosb0yZLGhjWj1KjXUhRY7DJQyWCvnSq6DwBkeGGgXfLJRS6PipY+1sPnW0LOW5vIlZhyz36zvWk3zqTlkOoo8AjovsDEJlPM60SfIiJRFMqyyNUCOFTRB9vygfHDgzuuCY3s9OC83xsTULkAfy1pdqy6HI+Xn0gm7TyHuP/0Se0nl/G03ECcI4BBs5tB5A54ikyvchRg/cNUSZN4CPgxOf/aCQeX1p+eoUzzJKsQbMvbxM9rKc0Mbce0WH0ajkju+3C8I/qevM1Wcvs+QPW8JESY4QB8T580UTeJeFPbuRzqWQttgf8ul14T/m05TL1vi0oDf7mIoY5oKFIs1ZcNaJCvbh8z4VApdOk7VQrK9zFDp22YX3l7WfM6Be8Y/Ku2MenrSGXXxMYCxDt3FVPC0kBea3rALYIYtOPrrDufUJcs5QPOKRhOs1QUpgjXYq97s6+D5Ft0sLG1L3q4Dflo869t25cyJuXAMhyVtxoD6PesNkZlzFGvldxJOXUR4PHzlOjxVPN9OKEadE0xlIfJmfdDd1pA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(36860700016)(1800799024)(376014)(6133799003)(18002099003)(10067099003)(11063799006)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: LqL3ikPDDN/n0OCVs+LBhb+KKlxfwgAo5fDqBcKgSUdu/G1+t/QK2yfvutkE9k1FWwvWfM27TIeCKXTdkj8Ulo6Tqpd/a+9lr66ctRR465xDO9cBrmN0h6OIOMD8wN/qVWqq1EVWS2tGn12pFmjL3XRytFEMqQ+A3J9L8nAkABHJDDejksYanAlstaSuRoBuCtr9/84CavASkDPZ2t6SEBlpdbZusRaMACKWX8PIJqFc3n88Qy0jXA+KucVT0XjkWMGKmrUkxfnfX5fv4GnOgiK84nh84+V0zr0QLCobB5+j/Ev9JEm4uj7FzXysERpMeZ93MOfqPk14EPBNCu9YEqKBAd5qzOtqV4wTsc7rlO1Q2+hDkTMcUU4SeS1ar4QemU6BqVkzXwSffKy7zZwgvYb6duuqg1InHop7+UHUTNp4gfRWT8d30CbfOzHKCPoB
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 14:19:12.9426 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b6518b67-2c57-454c-afe7-08df2eb51d9a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MW2PEPF0001467A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7137
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

Since commit 9c105255108b ("pinctrl: pinconf-generic: perform basic
checks on pincfg properties"), the generic pinconf parser logs an error
when a pin configuration node specifies more than one bias mode.
Several ZynqMP boards described SDIO card-detect and write-protect pins
with both bias-high-impedance and bias-pull-up, which triggers at
pinctrl probe:

  generic pinconfig core: /firmware/zynqmp-firmware/pinctrl/.../conf-cd:
    cannot have multiple bias configurations

On ZynqMP, bias-high-impedance enables tri-state while bias-pull-up
enables the internal pull resistor; these are mutually exclusive bias
settings and only pull-up is needed for CD/WP inputs. Drop the redundant
bias-high-impedance property and keep bias-pull-up.

Reported-by: Mikko Rapeli (Linaro) <mikko.rapeli@linaro.org>
Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm/dts/zynqmp-sck-kv-g-revA.dtso   | 1 -
 arch/arm/dts/zynqmp-sck-kv-g-revB.dtso   | 1 -
 arch/arm/dts/zynqmp-zc1751-xm015-dc1.dts | 4 ----
 arch/arm/dts/zynqmp-zc1751-xm019-dc5.dts | 2 --
 arch/arm/dts/zynqmp-zcu100-revC.dts      | 1 -
 arch/arm/dts/zynqmp-zcu102-revA.dts      | 2 --
 arch/arm/dts/zynqmp-zcu104-revA.dts      | 1 -
 arch/arm/dts/zynqmp-zcu104-revC.dts      | 1 -
 arch/arm/dts/zynqmp-zcu106-revA.dts      | 2 --
 arch/arm/dts/zynqmp-zcu111-revA.dts      | 1 -
 10 files changed, 16 deletions(-)

diff --git a/arch/arm/dts/zynqmp-sck-kv-g-revA.dtso b/arch/arm/dts/zynqmp-sck-kv-g-revA.dtso
index 45396e420433..fc8d3467198d 100644
--- a/arch/arm/dts/zynqmp-sck-kv-g-revA.dtso
+++ b/arch/arm/dts/zynqmp-sck-kv-g-revA.dtso
@@ -403,7 +403,6 @@
 
 		conf-cd {
 			groups = "sdio1_cd_0_grp";
-			bias-high-impedance;
 			bias-pull-up;
 			slew-rate = <SLEW_RATE_SLOW>;
 			power-source = <IO_STANDARD_LVCMOS18>;
diff --git a/arch/arm/dts/zynqmp-sck-kv-g-revB.dtso b/arch/arm/dts/zynqmp-sck-kv-g-revB.dtso
index 22faec35f793..80d1577c92bd 100644
--- a/arch/arm/dts/zynqmp-sck-kv-g-revB.dtso
+++ b/arch/arm/dts/zynqmp-sck-kv-g-revB.dtso
@@ -394,7 +394,6 @@
 
 		conf-cd {
 			groups = "sdio1_cd_0_grp";
-			bias-high-impedance;
 			bias-pull-up;
 			slew-rate = <SLEW_RATE_SLOW>;
 			power-source = <IO_STANDARD_LVCMOS18>;
diff --git a/arch/arm/dts/zynqmp-zc1751-xm015-dc1.dts b/arch/arm/dts/zynqmp-zc1751-xm015-dc1.dts
index 2897c423f82e..7942e632d047 100644
--- a/arch/arm/dts/zynqmp-zc1751-xm015-dc1.dts
+++ b/arch/arm/dts/zynqmp-zc1751-xm015-dc1.dts
@@ -285,7 +285,6 @@
 
 		conf-cd {
 			groups = "sdio0_cd_0_grp";
-			bias-high-impedance;
 			bias-pull-up;
 			slew-rate = <SLEW_RATE_SLOW>;
 			power-source = <IO_STANDARD_LVCMOS18>;
@@ -298,7 +297,6 @@
 
 		conf-wp {
 			groups = "sdio0_wp_0_grp";
-			bias-high-impedance;
 			bias-pull-up;
 			slew-rate = <SLEW_RATE_SLOW>;
 			power-source = <IO_STANDARD_LVCMOS18>;
@@ -325,7 +323,6 @@
 
 		conf-cd {
 			groups = "sdio1_cd_0_grp";
-			bias-high-impedance;
 			bias-pull-up;
 			slew-rate = <SLEW_RATE_SLOW>;
 			power-source = <IO_STANDARD_LVCMOS18>;
@@ -338,7 +335,6 @@
 
 		conf-wp {
 			groups = "sdio1_wp_0_grp";
-			bias-high-impedance;
 			bias-pull-up;
 			slew-rate = <SLEW_RATE_SLOW>;
 			power-source = <IO_STANDARD_LVCMOS18>;
diff --git a/arch/arm/dts/zynqmp-zc1751-xm019-dc5.dts b/arch/arm/dts/zynqmp-zc1751-xm019-dc5.dts
index 722b2e833b44..34b68cbc1e9e 100644
--- a/arch/arm/dts/zynqmp-zc1751-xm019-dc5.dts
+++ b/arch/arm/dts/zynqmp-zc1751-xm019-dc5.dts
@@ -285,7 +285,6 @@
 
 		conf-cd {
 			groups = "sdio0_cd_0_grp";
-			bias-high-impedance;
 			bias-pull-up;
 			slew-rate = <SLEW_RATE_SLOW>;
 			power-source = <IO_STANDARD_LVCMOS18>;
@@ -298,7 +297,6 @@
 
 		conf-wp {
 			groups = "sdio0_wp_0_grp";
-			bias-high-impedance;
 			bias-pull-up;
 			slew-rate = <SLEW_RATE_SLOW>;
 			power-source = <IO_STANDARD_LVCMOS18>;
diff --git a/arch/arm/dts/zynqmp-zcu100-revC.dts b/arch/arm/dts/zynqmp-zcu100-revC.dts
index 81353b60b38b..2ebba269d208 100644
--- a/arch/arm/dts/zynqmp-zcu100-revC.dts
+++ b/arch/arm/dts/zynqmp-zcu100-revC.dts
@@ -337,7 +337,6 @@
 
 		conf-cd {
 			groups = "sdio0_cd_0_grp";
-			bias-high-impedance;
 			bias-pull-up;
 			slew-rate = <SLEW_RATE_SLOW>;
 			power-source = <IO_STANDARD_LVCMOS18>;
diff --git a/arch/arm/dts/zynqmp-zcu102-revA.dts b/arch/arm/dts/zynqmp-zcu102-revA.dts
index 4d5f4754171f..1af7b889cbf5 100644
--- a/arch/arm/dts/zynqmp-zcu102-revA.dts
+++ b/arch/arm/dts/zynqmp-zcu102-revA.dts
@@ -947,7 +947,6 @@
 
 		conf-cd {
 			groups = "sdio1_cd_0_grp";
-			bias-high-impedance;
 			bias-pull-up;
 			slew-rate = <SLEW_RATE_SLOW>;
 			power-source = <IO_STANDARD_LVCMOS18>;
@@ -960,7 +959,6 @@
 
 		conf-wp {
 			groups = "sdio1_wp_0_grp";
-			bias-high-impedance;
 			bias-pull-up;
 			slew-rate = <SLEW_RATE_SLOW>;
 			power-source = <IO_STANDARD_LVCMOS18>;
diff --git a/arch/arm/dts/zynqmp-zcu104-revA.dts b/arch/arm/dts/zynqmp-zcu104-revA.dts
index 4479ff735145..b03774bba937 100644
--- a/arch/arm/dts/zynqmp-zcu104-revA.dts
+++ b/arch/arm/dts/zynqmp-zcu104-revA.dts
@@ -373,7 +373,6 @@
 
 		conf-cd {
 			groups = "sdio1_cd_0_grp";
-			bias-high-impedance;
 			bias-pull-up;
 			slew-rate = <SLEW_RATE_SLOW>;
 			power-source = <IO_STANDARD_LVCMOS18>;
diff --git a/arch/arm/dts/zynqmp-zcu104-revC.dts b/arch/arm/dts/zynqmp-zcu104-revC.dts
index 0f1b1fd92a70..ec1b9168a1c1 100644
--- a/arch/arm/dts/zynqmp-zcu104-revC.dts
+++ b/arch/arm/dts/zynqmp-zcu104-revC.dts
@@ -386,7 +386,6 @@
 
 		conf-cd {
 			groups = "sdio1_cd_0_grp";
-			bias-high-impedance;
 			bias-pull-up;
 			slew-rate = <SLEW_RATE_SLOW>;
 			power-source = <IO_STANDARD_LVCMOS18>;
diff --git a/arch/arm/dts/zynqmp-zcu106-revA.dts b/arch/arm/dts/zynqmp-zcu106-revA.dts
index ad76159084ef..5a5d3884821c 100644
--- a/arch/arm/dts/zynqmp-zcu106-revA.dts
+++ b/arch/arm/dts/zynqmp-zcu106-revA.dts
@@ -946,7 +946,6 @@
 
 		conf-cd {
 			groups = "sdio1_cd_0_grp";
-			bias-high-impedance;
 			bias-pull-up;
 			slew-rate = <SLEW_RATE_SLOW>;
 			power-source = <IO_STANDARD_LVCMOS18>;
@@ -959,7 +958,6 @@
 
 		conf-wp {
 			groups = "sdio1_wp_0_grp";
-			bias-high-impedance;
 			bias-pull-up;
 			slew-rate = <SLEW_RATE_SLOW>;
 			power-source = <IO_STANDARD_LVCMOS18>;
diff --git a/arch/arm/dts/zynqmp-zcu111-revA.dts b/arch/arm/dts/zynqmp-zcu111-revA.dts
index a9a473602374..e13e93847bd8 100644
--- a/arch/arm/dts/zynqmp-zcu111-revA.dts
+++ b/arch/arm/dts/zynqmp-zcu111-revA.dts
@@ -778,7 +778,6 @@
 
 		conf-cd {
 			groups = "sdio1_cd_0_grp";
-			bias-high-impedance;
 			bias-pull-up;
 			slew-rate = <SLEW_RATE_SLOW>;
 			power-source = <IO_STANDARD_LVCMOS18>;
---

-- 
2.43.0

