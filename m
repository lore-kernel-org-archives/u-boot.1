Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95CC5C5DF81
	for <u-boot@archiver.kernel.org>; Mon, 24 Aug 2026 07:24:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5D8F340433;
	Mon, 24 Aug 2026 07:24:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TT-xQrEY3HeD; Mon, 24 Aug 2026 07:24:37 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787556277;
	bh=AtwD8KbO50QDgqH3s17Sg4nItelv9BUsU8YJaAeFJh0=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=V1eF6bO3OametKKme9p84MPlGK5lnAB5uS5SJUGA1g3jIblNUoTvLeJkX1fgN7i2a
	 7TU7DrzP3hXrPtM6sAaNdkr5EcQ4rNHVcWqFe6zwDsN8WvlLgn29vVw7ffOBl62aLI
	 ir03weuwAc7osHmGyuKA40meJ9FM6SFuZYq6NW0MIw3a1/S30ts2FzIAdqeikXnD8F
	 qYeD7L1/8NkR0+WfTB+OmPC6DtKxEoF+gAsChUr86b6qAgq5D7rl7tB4cNgUpwM3Su
	 uJVgFaLv71v9p8iYCZyRsa5UEhnYS5dDNYn4KGnEfjW4cTav7y8OzjpVeOT/F1kE4t
	 6QQCubrXsuLxA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8E170404FF;
	Mon, 24 Aug 2026 07:24:37 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 7F510386
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 07:24:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 718D780AEC
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 07:24:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5XM8sG9sjprN for <u-boot@lists.u-boot-project.org>;
 Mon, 24 Aug 2026 07:24:34 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c112::7;
 helo=cy3pr05cu001.outbound.protection.outlook.com;
 envelope-from=pranav.sanwal@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=X1Eunw7h
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::7])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C530B80CBA
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 07:24:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UYi9V57UMfTxASMbQ/+wPbGHOKuyWXahGzyx5P5NtCxM4WpYksbY2NrsBi/azeuLgo0Ju+oSjT5DQGDnyXRzSdJmPaMc/SrXSdVmw6u6wvG4TqsKKjdk4kd6vzGeEKty42FXs3vzZsEZ6t7yJ4grUQGvczMYF7Kz0AjMPbCzfVBVktpItQ/7XA5cQFMgyfBN0gdD2j8sJbEiLtLqI8v6H/w9HZwkCuXeCGkjfUYsJQfEnwm++BZEQxNxecn5fkiGkBwtF9dj03OapuIKD4b9qH86EB+Upt+zhRF7Sks58pUHJPS08PCL22ZDXJ4w2jIIXBsmH0bHLdTAV5iZrK/lpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AtwD8KbO50QDgqH3s17Sg4nItelv9BUsU8YJaAeFJh0=;
 b=TP2ZxNB2oOM5QU0Yog9hLA8cyogLHNc4N7BP3tFx+DRnfrDAf2Rp/NhRuFbR0NRf8iuGgWvTQMx7xr6XBIKGvBl12kTABIuO+6nCclvjeSTQwkVnOcPiAiBWgW7s5T81Q0As9yPdqSV81fahaz8XZyPZF2SJ4r7nlgXd+EmuJj1/9TOmhrZl1k5hKUlbLC5qE+j11OJiCzBLmV1J/0tf9pb323RJgFU1cb27cbx0iEMT3oMw4JXvNCUK7l+irmHLFur8Eem5CZUVTIk9MsgygIxSbxXp8uST0JQs86Lon+N/7t8443nWT9i/ta7Tjh96yXC4prtvMsjq+KIZh9YsdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AtwD8KbO50QDgqH3s17Sg4nItelv9BUsU8YJaAeFJh0=;
 b=X1Eunw7hX569rcVVkulZmORrpbJ1ZNOTaLvfGlVrt8En2BKRtXQJUMG1NYwp1Nz9BtWxHIfjGxb6NK+YiyMTsAlisGO9qnivKmT9pmFbsJaAATiO/R7siDeVUL5TY6bueHV+2GCtsFTa9wFeyQf8kytUp23QltbzN3zN27fhMT0=
Received: from PH8PR20CA0002.namprd20.prod.outlook.com (2603:10b6:510:23c::6)
 by DS7PR12MB8231.namprd12.prod.outlook.com (2603:10b6:8:db::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 07:24:30 +0000
Received: from SN1PEPF000397B2.namprd05.prod.outlook.com
 (2603:10b6:510:23c:cafe::2f) by PH8PR20CA0002.outlook.office365.com
 (2603:10b6:510:23c::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.12 via Frontend Transport; Mon,
 24 Aug 2026 07:24:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SN1PEPF000397B2.mail.protection.outlook.com (10.167.248.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Mon, 24 Aug 2026 07:24:28 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 24 Aug
 2026 02:24:22 -0500
Received: from xhdamitn41.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Mon, 24 Aug 2026 02:24:20 -0500
From: Pranav Sanwal <pranav.sanwal@amd.com>
To: <u-boot@lists.u-boot-project.org>
CC: <git@amd.com>, <michal.simek@amd.com>, Uday Hegde <udayh@amd.com>, "Tom
 Rini" <trini@konsulko.com>, <u-boot@lists.denx.de>
Subject: [PATCH 4/5] arm64: versal: Add MMU mappings for CPM5 ECAM config space
Date: Mon, 24 Aug 2026 12:51:48 +0530
Message-ID: <6347f49064eb6735b245d47e17e58c855c6528e3.1787554549.git.pranav.sanwal@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1787554549.git.pranav.sanwal@amd.com>
References: <cover.1787554549.git.pranav.sanwal@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B2:EE_|DS7PR12MB8231:EE_
X-MS-Office365-Filtering-Correlation-Id: 4dddd9f3-9198-4bf8-50fe-08df01b0bbfb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|1800799024|36860700016|376014|56012099006|10067099003|6133799003|22082099003|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: aQWpECnvZy5pglQt0JEHfuz/5iTq8spk9tFG6Cv4cRI+18q87YOGGhqgki/sEqqbo8umKdtyXnmw5hSpbZQ+UaIqxlukBDvwT1kxk8g3EpW5qnTPH8zGo4Tdhfj+GKEqANCnJBMIiXUqpBOofsF3AS0yEK3Kn3eNIihXtR4N/kDUzXw7i1BnQsyw2I8GnvO0bjFllb9HGllPHbKTXywnYHcB42gNMsYCJz7PUOiZL77XpWEf+lCqC6MzMWZ3QmN+pYVgCSd2QpLoa8otB+WYk8z+leALrD64mG4XLgBxi5phZEkD/LsqDm6j2Ac83akbptR9T+sMCgJ/oYJqe0zcLQm5FHXOEh4TzYQvFihbUqXwPH7/BmoEbr1G2+jPUCu28mhehn8ihewGUSxciZ+6oY3k2ssM8Y/d3HUjbYDyyqcVsGm8oe6Sv2jWBxeg5ruXmfqbd9pgsRyHEsxlgpMy6tZ1jkKSZcQ/QSvv6YBThBu0jX4ZsUnF4jp85wtmHICt2+2FtLNaoVoZDKOx1aRl0bF8Iw3WHSfWKZ4eHXxHVkYTehmwEeqVONdrZZIuqrJZCoihc1JbQDRh8wwAKXQNi18Ouv8TrrVnVIYVSIQ0wVi2BxtGFUX8n1KlpeW32kuGEpK2TDieXq9faXseSj056ZjoepJjlk0V1RFJwt1rxiznhbvQKduiG8fYay/ASx1wmgu9tMYMbKbUpUr1xY1Asw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(1800799024)(36860700016)(376014)(56012099006)(10067099003)(6133799003)(22082099003)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: /uMRl1Ro3ec122hoJWXTC9qge3baa4Kwsn9LlyWBx97VP/LPvnzRA8XQ2yaAZFI3ycQwF+QtX7EQegcMpMCTaVZWJADIAEHmmqAwitdhRoFGTFhLEZOWWePe+J5LxtfhTkxrADfwVcW/Dboop9n3qftnoACIWemZir0BeEwwBUy1cnoXlLgwZY/QxU76qvoJfc4UG+24U763cZjhUvfJDkNlBLLA59dgB6QefRo1nJpNPHBOSlZU2ubzhmXzMnmG70aYcUTX6kkYr/6wc8Kc7mnRyOQGOQUqLDCTFI2FGXw+7tlUxCz5XY/rIBUNPBVQaqsVwJlUYzl/3mtULZxHX6ouU+tcnvbydwyhPBQBSHF6soClit+ck7phf5WFFShtXWrFGuu7Yn1NWxRRWob5MGWb4RI/uIgOL3/YKktO6Qlj8px+6nWImZS33CFv3ZYm
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 07:24:28.9252 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dddd9f3-9198-4bf8-50fe-08df01b0bbfb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8231
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

CPM5 Host0 and Host1 each expose PCIe config space (ECAM) inside their
4 GiB NoC address slot, at 0x600000000 and 0x700000000 respectively.
Per the DT "cfg" reg and the PCIe ECAM spec (256 bus numbers x 1 MiB
per bus), each window is 256 MiB. Config space accesses must not be
cached, reordered, or speculatively issued, so map each ECAM window as
Device memory (MT_DEVICE_NGNRNE).

Rather than mapping 0x600000000-0xe00000000 only when
CONFIG_PCIE_AMD_CPM is enabled, add it as a baseline Normal/cacheable
entry unconditionally: this NoC/PL address space is shared by more
than CPM (PL fabric AXI space, other NoC-attached peripherals, etc.),
so it needs coverage regardless of which PCIe controllers are built
in. The two CPM5 ECAM sub-ranges are then overlaid as Device memory on
top of that baseline only when PCIE_AMD_CPM is enabled.

Update VERSAL_MEM_MAP_USED to match: 3 entries when PCIE_AMD_CPM is
disabled, 5 when it's enabled (+2 ECAM overlays).

Co-developed-by: Uday Hegde <udayh@amd.com>
Signed-off-by: Uday Hegde <udayh@amd.com>
Signed-off-by: Pranav Sanwal <pranav.sanwal@amd.com>
---
 arch/arm/mach-versal/cpu.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/mach-versal/cpu.c b/arch/arm/mach-versal/cpu.c
index 7521d45bc1a..5dbd0fcc438 100644
--- a/arch/arm/mach-versal/cpu.c
+++ b/arch/arm/mach-versal/cpu.c
@@ -20,7 +20,11 @@
 
 DECLARE_GLOBAL_DATA_PTR;
 
+#if CONFIG_IS_ENABLED(PCIE_AMD_CPM)
+#define VERSAL_MEM_MAP_USED	5
+#else
 #define VERSAL_MEM_MAP_USED	3
+#endif
 
 #define DRAM_BANKS CONFIG_NR_DRAM_BANKS
 
@@ -55,6 +59,22 @@ static struct mm_region versal_mem_map[VERSAL_MEM_MAP_MAX] = {
 		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
 			 PTE_BLOCK_NON_SHARE |
 			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
+#if CONFIG_IS_ENABLED(PCIE_AMD_CPM)
+	}, {
+		.virt = 0x600000000UL,
+		.phys = 0x600000000UL,
+		.size = 0x010000000UL,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
+			 PTE_BLOCK_NON_SHARE |
+			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
+	}, {
+		.virt = 0x700000000UL,
+		.phys = 0x700000000UL,
+		.size = 0x010000000UL,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
+			 PTE_BLOCK_NON_SHARE |
+			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
+#endif
 	}
 };
 
-- 
2.43.7

