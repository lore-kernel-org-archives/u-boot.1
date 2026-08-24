Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55B57C5DF94
	for <u-boot@archiver.kernel.org>; Mon, 24 Aug 2026 07:22:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D15D380CC2;
	Mon, 24 Aug 2026 07:22:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9yxZkn-IqIw8; Mon, 24 Aug 2026 07:22:43 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787556163;
	bh=rjQvJcsIQgsL93Jpi6ITOhZgsgU1tH7oO/y96iJV6Lo=;
	h=From:To:CC:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=PIAyjIfHEt4cXiK6KM4KIviPHd3nIM5OXMKBdW6yZoPKAw0jUG+OiM2SpZ8fTaXNO
	 KYw8BnZS8z0x2+1h8Z1dTYQZ/bOl02s+dgLFGmcNqauO8d91PaLValUYF8lMNLfTbI
	 VyJmiKbpMyaoaUC68/f2b9CWa+pmuOE5+oPpcZI/EbRDgewjC8A+ZmFtmQs7AHq54Q
	 +XNlDtThnkRnfwbBDGFJNLC3LDKCbmLFxgoU7eJafassk5sHMzB4pZz59PRhqkQb0W
	 AgxCEhcjNrfo5BdicPvuJtL8uTrKk7dH9fNI8iM3CEFMwcSgdAxwl7r1DRWLhBnpC+
	 KLFjSBPziCC7w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 11F0F80CBA;
	Mon, 24 Aug 2026 07:22:43 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 6B88B396
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 07:22:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5257080CBA
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 07:22:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ryxU98kv1gTL for <u-boot@lists.u-boot-project.org>;
 Mon, 24 Aug 2026 07:22:40 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c007::2;
 helo=mw6pr02cu001.outbound.protection.outlook.com;
 envelope-from=pranav.sanwal@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=YbL+Z98J
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c007::2])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6DA9B80BB5
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 07:22:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nm5CCw7qeow5uVfEhKkYSTpk0WOkNYYjE7oSGX1VCVDEU/YoHryUPIS50Ebc8apxyDuXL6vhdT30rqQ0YEWM0L7c/Zkre4Ej4UKNKFvSgPPTsz+5yX3h6yzPNyR67+egjHGrSTiPnDxeIAHPGGDslcuri29WoU6f4tcA1TI4OqhPGG/IHUe7tpIb7kGqvbRbxTx9c/gjC/E2aE3jYixDwUQWo3mzpAluMugdEI3CA039B+XwqEpqX7JvauFLy7s5UyjL6qC7q135v+O0rpYMCE1WVj8peJwV61J1EpLPKod3xfmZ6E2pAupE9jwSV/e9JtgEQda6d2HQRMIIBWkE4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rjQvJcsIQgsL93Jpi6ITOhZgsgU1tH7oO/y96iJV6Lo=;
 b=DtoAoF11UsaCsgv704PF/r5I7x5s7svkzc2Wt/aiY8kvHn4ch2fs/m6V8HEcNRZXOeLcZN3Z8CYQd9PJGb4tsAO55iEax7+SvOmogxZ1pN3u0GcU/AmBmuEfnpnS7VAhfopWJB9zghmALYuKGt+cCjq+K4yPkJSC24qmT6T6CS0oaqThdrgF7k9QAVUPyLGCABJ2UobTKYx9gPvkmjP7sVn1vpyj4THoHTsBaHpfEgDFyzqzKNli1b3N3bD2KsIzb3po4kgZvdDXcFgqofaDT0E/DcsEryDCCeW3OulYs7XKJQmj3Oo6M4eRnD3UUqb487zIikpZFNofMdda/ym8Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rjQvJcsIQgsL93Jpi6ITOhZgsgU1tH7oO/y96iJV6Lo=;
 b=YbL+Z98JAl0rR+BQzHYnmRyjSiJgmkE4gCBtZb/rHBaGT4NtXPPBNHDWJHTsSg5klUPj6/FdJEYP0HYZPZsFfEYzxOO3MrprSMEw9fY+quS+9KhBHlUVQwMiKUGQix/0BCuVbeMlf/dfUK3xSviKJ//BqsU5loQnMu/epVN+itM=
Received: from SJ2P221CA0006.NAMP221.PROD.OUTLOOK.COM (2603:10b6:a03:5db::6)
 by DS0PR12MB7536.namprd12.prod.outlook.com (2603:10b6:8:11c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 07:22:35 +0000
Received: from SJ1PEPF00001CE2.namprd05.prod.outlook.com
 (2603:10b6:a03:5db:cafe::83) by SJ2P221CA0006.outlook.office365.com
 (2603:10b6:a03:5db::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.12 via Frontend Transport; Mon,
 24 Aug 2026 07:22:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF00001CE2.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Mon, 24 Aug 2026 07:22:34 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 24 Aug
 2026 02:22:31 -0500
Received: from xhdamitn41.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Mon, 24 Aug 2026 02:22:30 -0500
From: Pranav Sanwal <pranav.sanwal@amd.com>
To: <u-boot@lists.u-boot-project.org>
CC: <git@amd.com>, <michal.simek@amd.com>
Subject: [PATCH 0/5] Add AMD Versal CPM/QDMA PCIe support
Date: Mon, 24 Aug 2026 12:51:44 +0530
Message-ID: <cover.1787554549.git.pranav.sanwal@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE2:EE_|DS0PR12MB7536:EE_
X-MS-Office365-Filtering-Correlation-Id: b3cadd45-b130-48dc-66b2-08df01b077d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|82310400026|376014|23010399003|18002099003|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: GxXAfwev+20Z/vUSTcSyw2PZ24y5D6EZGwy7s9cb7KbzB7eEp+cmH4b7vCuaTfVLWhsjgGJBaddVE5iTpt78hBZ/1Q+SYY4TYU1vWoUjhvNK5ktheM6eyzwSnZuU0+t09SDwOm4XaHT/f70oGezLbPtzTPVkGAyvM68PbOPydePIXcX2CMB6K6eIM0Ak+hwr1QtAlcv4KYNvKGakwCXS9+mGrqE7fNyL54cJ7aBcyujh9jz/qDvI3qraztsQZ2LvSrHklW4OwUNJ5DNUKqAkjYVuUX/5uYXXiFAwLjtZxvt5ag3ErfJSvybepfOXFb1StmJ7y7Eyee1ehPwVE9NuN5YJ/FUVDKSke2zkESvHtMG2qLshBZLHuFh1IUw8XvTSLOu7mbU7tQUGUSzQlGHuCbXDvUtM73ycRtSQr3DJF92qVsb+Wt7eoi9wfkXbKdG7dUzJu5BJmtdKuZr8y8WEvd/HQTemgBrH0zJjhhmoA2QgklIopIc4N76Ju2jjZdfnU09321VdPyysc5tu9BWzdPrZT1St1LK5lz0ai/LNw98pDvBxlhBESC6iDoTq+ctz15D0dZxhwVHJaR1gktMpBUiLZhrOtKfsYYhqmjpSmvAwTCIy/Ixc5h3QlOS9cuJK/PRscu4xUJT6p6v7CzDzm5uEKeNqdY8BdRJGMOr8noHYskBtf6wcq/NXPK+JbxpT0zfCw6a4ff+epDSwzjN/Nw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(82310400026)(376014)(23010399003)(18002099003)(11063799006)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: XQRr3ESGfvlMeAOCmNyDnvARv8sqwnwui1h3sN0lxwUjHVmBu8h4DI4zUahzH6mAYtMyvIZDhHD0TwqZqwIBPqSXq1tmyC6HXXbspj4ODIDXmgdh+rtQN1IiwagySTtBVgjq6WwZN3EqUxm3GFMVDlO/xTd0RMMANoWNE5D0QlgZPtZWTJFR9Ps+mfJYkSoQ/CmmzKaapO6HYgPwS5vzh/FXyjNXjovuO52CdXyCcZs76cY7iwKiOGHCL8Z/6Ymq0KfVS+r50ITUXumxWimMJzvS3B3qBKv8eYWwhDS9KWZ3OCno0fwb1O2ZB0rv8ZCfYjegdVIMR3r9VGXrrrClyCwWXEtxoAPyfNFojQC+mX4FVPnJluG1dOP8V9lH+KO8XAt5Xx4FOmEQovNZvr0Gonnx+k+SQLYxthDDQZE9LVkHTiyp+54q3G3XqG5Mw6zV
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 07:22:34.5175 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b3cadd45-b130-48dc-66b2-08df01b077d8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7536
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

This series adds PCIe root port support for the AMD Versal CPM4, CPM5
and QDMA PL (soft IP) host bridges, and enables it along with NVMe
storage on the xilinx_versal_virt platform.

Patch 1 adds a generic mmap config-space write helper for host bridges
that only decode 32-bit accesses.
Patches 2 and 3 add the QDMA PL and CPM4/CPM5 host bridge drivers,
respectively.
Patch 4 maps the CPM5 ECAM windows as device memory so config space
accesses are not cached or reordered.
Patch 5 wires everything up in the versal_virt defconfig and adds NVMe
as a distro boot target.

Pranav Sanwal (5):
  pci: Add pci_generic_mmap_write_config32() helper
  pci: Add support for AMD QDMA PL PCIe root port
  pci: Add support for CPM4 and CPM5 PCIe controllers
  arm64: versal: Add MMU mappings for CPM5 ECAM config space
  arm64: versal: Enable PCIe/NVMe support and add NVMe boot target

 MAINTAINERS                          |  10 +
 arch/arm/mach-versal/cpu.c           |  20 ++
 configs/xilinx_versal_virt_defconfig |   6 +
 drivers/pci/Kconfig                  |  19 ++
 drivers/pci/Makefile                 |   2 +
 drivers/pci/pci-uclass.c             |  42 ++++
 drivers/pci/pcie_amd_cpm.c           | 363 +++++++++++++++++++++++++++
 drivers/pci/pcie_amd_qdma_pl.c       | 205 +++++++++++++++
 include/configs/xilinx_versal.h      |   7 +
 include/pci.h                        |  26 ++
 10 files changed, 700 insertions(+)
 create mode 100644 drivers/pci/pcie_amd_cpm.c
 create mode 100644 drivers/pci/pcie_amd_qdma_pl.c

-- 
2.43.7

