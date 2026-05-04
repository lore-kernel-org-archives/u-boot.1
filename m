Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1D26CD3423
	for <u-boot@archiver.kernel.org>; Mon,  4 May 2026 09:26:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2238A8394E;
	Mon,  4 May 2026 11:26:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Lg58GN4a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EBF5383EF9; Mon,  4 May 2026 11:26:45 +0200 (CEST)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B742F80F0E
 for <u-boot@lists.denx.de>; Mon,  4 May 2026 11:26:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sRgMzbg6LzKYfMBVEPTzrWwlCdGLP92FohBf5llkMKoT87+PoMGQKNwUQ/eRVslBDsENuvY3esEW+vq/wgcBQS00vgN3SBPLwrAjZhDl/4rFxU8sw3d3sLI0tNR8SRwcJp4Y5lCV3mVr7VtkWgpEhQXCXVeAf73BqsX+vlV4rcJpcQClcHUzLvQjIB65mNKmXbK0sLFz8gPMcu5f8loSJp7jR9grhyXxTzKdRlVe4yIMqv3CBU+3yXfHreGBqiBD409w1bJG/omoG0Uo/c4lUICBTUF3pMPqJwoLkvcti2BNtwbIDUQGuZxLm5jE+h17NQ4rvm8MixnWr/0HnJ0tSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=saG/huuci6hkAHzaMySW/dceN5E5ykSjYZ/y/5tStYg=;
 b=MeknwPPr/wCyd2ge6fPtp8DZiBXv1rg7wHAjRE28cTSqSEz+Sv8tXlAMmeGrXlwc3LaDI58oQ8CR4EV0nfr+gLe+DHfJ6ZIkfqX4vowwMnQsPj1hoRAnB6iAJiLqkCTIMOisV9VJURPeNUwjc4w7zgu5jvf/FQtiTmw9pJSsNCz/bwMkFmpcsnYM2Rp5GH5IfGZsmi3Ut30yFDCx4l0xXhzztbR+Ch/q46CEcHb6Y+yEXhZk45aaBhyW6yomQZ7krUevrSpC3XFxbaIoen2o0/bz47Yvz7qsczkKlDuucpsS7s39BJNZ/0ZERcJQaC8rjJyNIbXOXMkGVYBS5NW3NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=saG/huuci6hkAHzaMySW/dceN5E5ykSjYZ/y/5tStYg=;
 b=Lg58GN4ahZFzhkJ031ezqUHJagGivH0v9jrV87FOpZiXvedxPhtQ36GoDdUjDAveuYhn2CdgGMDBLumFyX6ZBARg4IGbAG9Iw0+hr9JGqseD+XB+YGHmBYf+3/KNOmFFvA1wGjYDxLbsgCXzGedJGcH0ZGAVtO1emxGqP7l3F4g=
Received: from BN0PR04CA0023.namprd04.prod.outlook.com (2603:10b6:408:ee::28)
 by LV2PR12MB5848.namprd12.prod.outlook.com (2603:10b6:408:173::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Mon, 4 May
 2026 09:26:39 +0000
Received: from BN2PEPF000044A4.namprd02.prod.outlook.com
 (2603:10b6:408:ee:cafe::ca) by BN0PR04CA0023.outlook.office365.com
 (2603:10b6:408:ee::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.25 via Frontend Transport; Mon,
 4 May 2026 09:26:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000044A4.mail.protection.outlook.com (10.167.243.155) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Mon, 4 May 2026 09:26:38 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 4 May
 2026 04:26:36 -0500
Received: from localhost (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Mon, 4 May 2026 04:26:36 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>
CC: Conor Dooley <conor.dooley@microchip.com>, Jamie Gibbons
 <jamie.gibbons@microchip.com>, Leo <ycliang@andestech.com>, Randolph
 Sheng-Kai Lin <randolph@andestech.com>, Rick Chen <rick@andestech.com>, Tom
 Rini <trini@konsulko.com>, Yao Zi <me@ziyao.cc>
Subject: [PATCH v2 1/2] riscv: Make RISCV_ACLINT visible
Date: Mon, 4 May 2026 11:26:28 +0200
Message-ID: <7e80b87009b327aa618117baf223973e10c5b611.1777886786.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1136; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=WwlvjKEMFdDVgfDSHqA6lCeELdPrlvak8vlMp3xtwao=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWT+SHO9UL7nOfMM+9yPu4Lut2VPuvr3j8STgtDggvd6i
 10XyPRt6ShlYRDjYJAVU2SZzqTjsObbtaViyyPzYeawMoEMYeDiFICJfNjDyLD8rUOVpOOitxzp
 v5T9J/+aurjlgjyL3or9wvd1ayeESq1lZJgbO8O50eIdR9nFcpump9ELvX+vK79myLTVd9PLtCl
 ztNgB
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A4:EE_|LV2PR12MB5848:EE_
X-MS-Office365-Filtering-Correlation-Id: b35774e5-3190-4136-dbb1-08dea9bf3ec4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: XDqxe7HF+3nYKfjU7FLCZmcFUEVZjjfjS5SZgSb+MIHwpGK+QN490h0e189t7Ql4CVMTvV7ZtEhphgkNlXVfUNVFdp8+QufZLt8my8RKeBig2o01NpMphASiW7JHMPfx97HFvO2/T7DmutifB/j3Br+7ewR8rO7tYL85raul1zt5Ogdz8+xVqdvQomPqMDgQhW4NrceBDKCBCjBzEjTFaa/dQ9EsalflLQPlyfuiGUtPa8enm11gIHGhpdg6yDvlYzBAJ11day+8MJgkzn/MstX5V1U+NdoIInLmF7fpvXEmU3aPpBWiA6GE0LdSUpyajsYGo08qIW596y7Bi1SMIqWqDNvYyGX2hmSY3jQLClci/vfKDPr/f/7oOwk5oHrT5xqseexCm1kci9/0nGxhsmDtKuSXEVygTO3rYSQairbGmZyOjArsjpyHdElRtjdyqX+3BpWhjXLntXFufj8pNyVsCJDaGFXu0C0FIpB0TfSZ5gaK2rUavayIuQLoxTg1xR9RpTP7YYD/LqSnUbR61ufT1/1Y6W1RJfHwvK8iO1mACgPM7FJvNU44IqR4OLIhadyOnRgrqsKbuynUpsGdBhNdu2DkPHrLwNXId0ZGPNCD8m2wZqDYwPN3scEOMr1At2WzPeiIRPZI0Sp9wk0rYT2Vdn5RBF0gXIbQbxK6UO8t2VJK4K5+rFFf7MvZQFGWVtEimVQbrQCKaUA94e/3VStLqN2g9N0TIRVkmhwEZiU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: bR0zcYKdiMfqlbXP9JoblNMNi5nrkR6gLlFNHrbSrTD5P/K+b0XiRi4EV9yRWvJaHr4GM35KFHYnBnsA+0J9c/kKVAlzRiT2xHsAEF6pX73Vz7lGx/AYZl53A1Idt5mpdypWIZooLIs/I5VL0s/7yGiKLzmNmklCEyNtkM0Q/dkA6QYRVGIJiqvZA2JvlWO5Rg/YyI6YdzjZ65XJ2h08905PZmBDkq8IW8T/YsuKVijW7wVKjVHjak8KAxfG6vsUlGUvqjdKxc0H0dldvMXnkOOKUDujfwB8Z4kvvnlEL+LvHrr6cS1IaxMgllUNeA8Ui2KzCxT1Ll42o3lOLfo/uK6vTTDPXep4rAfwZLMNAx5n2KmBuqvfJWwURGn8PrySY90HKB5QUDJhyapxMlMJ1QC6liMLEA1/F5ek5XX1uuC46sRlZpbWoPl2/P3tddOk
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2026 09:26:38.9740 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b35774e5-3190-4136-dbb1-08dea9bf3ec4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5848
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

A platform (like Xilinx Microblaze V) does not have an ACLINT (Advanced
Core Local Interruptor) hardware block.

Make RISCV_ACLINT and SPL_RISCV_ACLINT Kconfig symbols visible with
prompts and enable them by default

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

Changes in v2:
- Make symbols visible and disable them per platform basis

 arch/riscv/Kconfig | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index ad7589123c6c..d14086e9f4dc 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -378,8 +378,9 @@ config DMA_ADDR_T_64BIT
 	default y if 64BIT
 
 config RISCV_ACLINT
-	bool
+	bool "RISC-V ACLINT support"
 	depends on RISCV_MMODE
+	default y
 	select REGMAP
 	select SYSCON
 	help
@@ -387,8 +388,9 @@ config RISCV_ACLINT
 	  associated with software and timer interrupts.
 
 config SPL_RISCV_ACLINT
-	bool
+	bool "RISC-V ACLINT support in SPL"
 	depends on SPL_RISCV_MMODE
+	default y
 	select SPL_REGMAP
 	select SPL_SYSCON
 	help
-- 
2.43.0

base-commit: bb0f3eebb3c196d9b6efbbd1e5aa9b16abbb9ad6
