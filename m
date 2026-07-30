Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8320C54FD2
	for <u-boot@archiver.kernel.org>; Thu, 30 Jul 2026 09:48:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1F56480F03;
	Thu, 30 Jul 2026 09:48:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id m30fkWT5dWX1; Thu, 30 Jul 2026 09:48:41 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org F395180ED2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785404921;
	bh=PnkjNbkbjv64cAdbkCPD1WHBTWONstByJPRMHMQVun8=;
	h=From:To:CC:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=KafgAssRAfVzU+BxTL6ts+TMEvaf+FIh3Na3fUNU4f5ImQyB5Mzw9W8zRRnCIYe9I
	 WpuGX/3vYa1BV7IWg3Nma6QBciXV72yDOv267Bn5Am8iyv+kbq68d0WCBTlemrYkeg
	 bmd8XkPsIeHxm3TvmrqFjF/nnXSmhhPku9S+lSYf+ksLSzwE6ZP0/bM2MN1TJN2xH9
	 pwIc1qsoeMxS7UUYmhXi9N5ZuwBpsln17cS8H1PbY5XumN9VBu8CVtqItfkEU8ron4
	 b5L0OdXiaDQ5aCXRHtxARAKcpnMnfOXcpwE0HwtAcRceUO4Ob0Ad7+5TrwHQPBK+Db
	 ucyJaCSDQnXUg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id F395180ED2;
	Thu, 30 Jul 2026 09:48:40 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 5C99F352
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 09:48:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 42B23408F2
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 09:48:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BSLn6mJl9hte for <u-boot@lists.u-boot-project.org>;
 Thu, 30 Jul 2026 09:48:39 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c005::5;
 helo=co1pr03cu002.outbound.protection.outlook.com;
 envelope-from=pranav.sanwal@amd.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 9329F407FF
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9329F407FF
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c005::5])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9329F407FF
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 09:48:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SLxtEnlpmiVjE2pzZ/A/oazyEjApYySCvKByIbTcp/+Vv+3hzIojjkFvK59/E8krVwQ1Y1/n4glybS2/g6YSw51KcpKIDP/QC2TPaAczOiqRL64xByKSQ/mpJ2XWEm++EXDu4FDwzWSubIYs+IGXZCg2GjxCZjH95XTFBsKLljtNaNKzHRCnKTFLUFkxsL3PK2LctMmmYiJJn5h1jVIEZDgqYXB5RwE2jGf3L22yqkNIruOB8ThjsbycBHeVNCScODRdvYIfeCdGLbqLvyAkQ925Xz7IkMCfGYZj0iiV/CIv+IS1DNvSuVSFj8zMahcsFXhXdRxwpq+64Ei5g/0CMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PnkjNbkbjv64cAdbkCPD1WHBTWONstByJPRMHMQVun8=;
 b=uDs+4h+wVLNqMtAB1YrdCKinpS4GK2Z4XHCJWaR3jI12iDW0C1SO8SRKI8C4FlGkiYdoRmnJYXBwshvFPWfztgX9MVhQ1SMz/Z7kfPkH64EgmmFdbZgUkPchEeYjd14u3hZ3021TkdCfWE1rwC1cNGxQmSdovnwzhZ7gYnyio7//hPOA7ititrzlCAWlzCK86Hw7tSbURunYNBACrl0SMTt4vhjdb76OFILHViX+roTX0GYf/FO9HewrisXq4uSvPcAylYHf2n1EiHd9ofh9mVHBsu9VV7a1LapDFmgjWrdbLnG9RRMQQ0LK1eOdr9/dO+QAYSzsxXMxGxtnlPe44g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
Received: from MN2PR11CA0029.namprd11.prod.outlook.com (2603:10b6:208:23b::34)
 by SA1PR12MB9515.namprd12.prod.outlook.com (2603:10b6:806:45a::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Thu, 30 Jul
 2026 09:48:33 +0000
Received: from BL6PEPF0001AB71.namprd02.prod.outlook.com
 (2603:10b6:208:23b:cafe::7c) by MN2PR11CA0029.outlook.office365.com
 (2603:10b6:208:23b::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.15 via Frontend Transport; Thu,
 30 Jul 2026 09:48:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL6PEPF0001AB71.mail.protection.outlook.com (10.167.242.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Thu, 30 Jul 2026 09:48:32 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 30 Jul
 2026 04:48:31 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 30 Jul
 2026 04:48:30 -0500
Received: from xhdamitn41.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41 via Frontend
 Transport; Thu, 30 Jul 2026 04:48:29 -0500
From: Pranav Sanwal <pranav.sanwal@amd.com>
To: <u-boot@lists.u-boot-project.org>
CC: <git@amd.com>, <michal.simek@amd.com>
Subject: [PATCH 0/3] test: dm: add sandbox coverage for gpio-delay
Date: Thu, 30 Jul 2026 15:18:14 +0530
Message-ID: <20260730094817.1937340-1-pranav.sanwal@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB71:EE_|SA1PR12MB9515:EE_
X-MS-Office365-Filtering-Correlation-Id: e6d9adff-9eee-4114-a1f1-08deee1fb7ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|36860700016|82310400026|376014|11063799006|56012099006|10067099003|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info: x8zeF9oVMv93kHxPY4hrb4Ni1V1Wi+X6ZsCSn5vWuqdU00E/AIXU6v4DUiY7l8h4SatenrZQDxNrTJ6OObVbO9idWobvWiR9iDQIFoqnsuvJwwSY5xnmCWa0NaycBnJjg/Uy2xGX35H9lz4avIcLnG+jOzawXtO+ZCM8EKkDFJQStPKzn+BWZZGqBJtJD9hFjpMf0Yt7dWirPENegTkGW4fCCpYYpWEybpS5Ns+rWC1xcoueM6ELBLLCw6OTSWx6rKBN09C33dfmU0+cziPVSz9ifksj5WD/ikOtG7WmssX4/B4H7A/uZEgFtPXzdzuA7fmS25JNrgdoD7jc5IG0/2xBuzgTlTH8H38o73HDfitvg5Tj5pTet6k25x2e3ra/9dJ83ixJV7V9E0KVYBu6kR8a41n/elyhJg6tRStG4UoOf22sqkkWhlPUkfcKlNvcGS4DEoNYS/U8GEcSjA9EhtunNEG2yANIRRKZWHfUWVvZXZpfzyVhHPqjoY2fe4i9cmlf4TS6QLzJAdYS69QMxc4Ung1zd4qRG30JcgJrIsFQfPbw92q+0OeOuNFodtNyr0KxdS+2ViopqiTJXD7OG+Y56g0qm56NKhQLfWPiHpA37Ac/9ldw8gUZ3+6+JequbFVFeheD/3rfExXVuBw7yvelFoITeL7jyeWYhc6IHezPGw2DT8HckcAUg/j4l9uCYkkg2+Km1D+H7oQ3e2X6pg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(36860700016)(82310400026)(376014)(11063799006)(56012099006)(10067099003)(18002099003)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Vym5qKDEicY39aHmb5daURpkU0KXe/v241BinRxCJFdULr1Z0Kqh+QyMESgjIEQwYN/O+k2PbgEvrgBMsez3jP6L8nO548/LrQ9VTDEZM3qqSXjAVOQYt9mp5Amrnik3CQ/2oe4HrhWxH9KFqZMRbo0uiO4lFNJ5WVbqejMLBVNxV3UweaERtI+xPjOHdp6qcxvGuwWTPx3b3n8hWYxk171HXhZw3c69hv0aJHfVzMONeFTzPI+ScdaxrWKVSSS286fyVd9MiGyp50KwZeVruG9eGL+T38L8hSni88spphIxDTdxipWqDsEZfSPiGtV88QcBjk3F0yg9zoa5uZz5DuRc2nXWSVPT43NM1d222vV+/mIKIKITbZc/E8PKzYMB/Y+ubmPE9YQzGJ8FrKhkNic8/b48jQIpSRQKsh8IX8yF8cvn37XZySeJC5RFuiyK
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2026 09:48:32.5620 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e6d9adff-9eee-4114-a1f1-08deee1fb7ab
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB71.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9515
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PnkjNbkbjv64cAdbkCPD1WHBTWONstByJPRMHMQVun8=;
 b=hkT7YvR9iYF0xqqi0LUt3ai6PGXgcZIDRlBc80A2TLmfG2GadmG77VS4pIIvtoEKA9eG/6e50F6QoXJi9WmokNG3SOHxQn6aUHn1/Hug4PwRrbSi3DX+vYz3CxqkL3SgdPXycBkPkmu4jj+2e4PyL/IslJGoFzDKku+z+VmUpGo=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=amd.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=hkT7YvR9
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

The gpio-delay driver wraps one or more real GPIO lines and delays
their assertion/deassertion, but had no sandbox test coverage at all.

Patch 1 is a small, unrelated fix noticed while adding this coverage:
dm_test_gpio_requestf() requests a GPIO but never frees it, unlike
every other test in the file.

Patch 2 enables CONFIG_GPIO_DELAY on sandbox and sandbox64, and adds a
gpio-delay-test node to the sandbox test devicetree wrapping two real
GPIO lines (gpio_a 9 and 18), so the driver actually has something to
wrap during tests.

Patch 3 adds dm_test_gpio_delay, which requests both consumers wired
up by that node and checks that each is routed to its own wrapped
line, that a third, colliding consumer is rejected, and that a
request past the wrapped GPIO count is rejected rather than silently
accepted.

Depends on the already-sent v2 series "gpio: improve claim diagnostics
and fix gpio-delay offset handling":

https://patchwork.ozlabs.org/project/uboot/list/?series=516104

Patch 3 of this series (dm_test_gpio_delay) exercises two fixes from
that series specifically - "gpio: delay: set gpio_count and validate
index against it" and "gpio: delay: fix offset propagation in
gpio_delay_xlate()" - and fails without them applied first.

Pranav Sanwal (3):
  test: dm: free gpio in dm_test_gpio_requestf()
  test: sandbox: enable GPIO_DELAY
  test: dm: add sandbox coverage for gpio-delay

 arch/sandbox/dts/test.dts   | 10 ++++++
 configs/sandbox64_defconfig |  1 +
 configs/sandbox_defconfig   |  1 +
 test/dm/gpio.c              | 71 +++++++++++++++++++++++++++++++++++++
 4 files changed, 83 insertions(+)

-- 
2.43.7

