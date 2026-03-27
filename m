Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34DC410ED660
	for <u-boot@archiver.kernel.org>; Fri, 27 Mar 2026 12:10:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 79D3583DA7;
	Fri, 27 Mar 2026 13:10:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bSBlwxL0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1C45E83DBF; Fri, 27 Mar 2026 13:10:36 +0100 (CET)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F053E83C14
 for <u-boot@lists.denx.de>; Fri, 27 Mar 2026 13:10:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Pranav.sanwal@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NrhOZ0/avWEZfrfk5A1Hzf+qjdI2fiJDAgoTGP8hV0j685R/ukEn2YSm2s5HTvGMNVKMp0CwuV4BGyX6/qpg6Kq5tRWhwleXjs2WjeEkYszDgMIFG7KGq52MogKA1e53ljnn0T4QcszoBZyPD1jGySgyIK9f/PrENIDGn76h1TE98l16Whu411whlIoyekFwqi3BfalXvoqmhb3h7XzTGwpa6JALR/8Ae/mwZ0ncvkDokijurvSM4CypQy0MTxjdb79wJxMNIXh38unw9Uyzt85Ggq3WVuWCSFkS2vB7WuRvhI54hrPtz9F9MQKvyjymczzNm6pohVRw4LrxzQiq/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yFaXaASPytbqt5UVfe+Vr4IPur9fjR0kE5h90SKFz3c=;
 b=dVb4kcPmZTVlH1EqpipVdHg8MtMLUXFsnpInENZGwDnLAjbYeF+6Gx9OMqOXwyRfvNuMm2R9Enz9pswqJD6WQDejGeoYFzz98Lc6xNTYVUU9TorDE+io5AaiQnrujRXwg47SlCuxVPrFCzJOP6hZuvfkiCx+tALha3jlromQHUVj39Rk4Ged+R5lJFq//RvFJGn/sXzIg2yYoT+2P/9LDjvq+edtI/faYKw1nghByqMrJAbjYlOFfbSRFEDma2t3pWJ0gX2uhuSiVewiVYFq+Y/gvr0yYgvIwK+f9JCbpkZQx+clkSl7myZx0o6vWaRpznyqtUHYEMcl+ClfBCFUUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yFaXaASPytbqt5UVfe+Vr4IPur9fjR0kE5h90SKFz3c=;
 b=bSBlwxL0JXOg/TgZwVyvozWJVl453+SJhAYoKr4+1iYPV9sLWY6ZhgbjL7w1b7XjOEQKQuhHojsXKUoxS5s12/e89TrYhzHowdfWanQxIo54D1IxpGD+z63V+AV2IJy/zR9rJjsaseEubSNzjw02qSJZLhFeYpJW8quThd4smhM=
Received: from PH2PEPF0000385C.namprd17.prod.outlook.com (2603:10b6:518:1::6a)
 by DS7PR12MB6262.namprd12.prod.outlook.com (2603:10b6:8:96::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.10; Fri, 27 Mar 2026 12:10:29 +0000
Received: from CY4PEPF0000E9D6.namprd05.prod.outlook.com
 (2a01:111:f403:f912::5) by PH2PEPF0000385C.outlook.office365.com
 (2603:1036:903:48::3) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.32 via Frontend Transport; Fri,
 27 Mar 2026 12:10:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9D6.mail.protection.outlook.com (10.167.241.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Fri, 27 Mar 2026 12:10:28 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Fri, 27 Mar
 2026 07:10:25 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 27 Mar
 2026 07:10:23 -0500
Received: from xhdkummari40.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Fri, 27 Mar 2026 07:10:22 -0500
From: Pranav Sanwal <pranav.sanwal@amd.com>
To: <u-boot@lists.denx.de>
CC: <git@amd.com>, <michal.simek@amd.com>
Subject: [PATCH 0/3] Add PCIe and NVMe support for AMD Versal Gen 2
Date: Fri, 27 Mar 2026 17:40:12 +0530
Message-ID: <20260327121015.996806-1-pranav.sanwal@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: pranav.sanwal@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D6:EE_|DS7PR12MB6262:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f2ce6ec-dedb-4723-3e15-08de8bf9d5d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|376014|82310400026|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: PrIsZPUO/Cd31xsn1fmSxU22T8i8KNkfbeID5nnmFLqEVH7oTZODTVLcRs0I14pQVaLBe23aJSLV6wcI3Ba0kRqAqXFZPIjjgEwvO3lKXa1pa5MdMjW5DvG1vFFLhwdhVMuHXS6WHHlK1xOrP+3hJifTIshOavW336Job0WoEN0u/Ixki/c3ywUrVz2IUEaY+BCuwbvit98Wj6SQ6b9Ps2rQGcp/O7mTNPRNl/F2UW/BdjZ+NkikMW41jkNh5XqKhZl8MTsIKNr6mKRTBd6r19tPm9e/s/aWZcLPdyjhWkNjJ7BTYdC9ok5/Lxj/ep0+YQ7wuECRvHtXQBFSTPQNg112T3ORa/RT1TdTd9v2jMhLhH30jbJiagxQLn44MLEGQ2QcNUgOZepQ+dwhhAGBMp37HeKm0dw8Ek1BOe4Fd4oX979H9VNEyPxtMIutb/MBERJtZncDOJ+AP1hki6u7lR69zhw6wTt0RHtvip222c7tXcYTEpTb9XeGb4oSgDcZCQzgnASaV3biUvt/2OcEnX7pcubQOgngqQniJFlPCpOfEbV/yyeQc/r7j5ZR1lSMqZPcTjUTisdYpEH6hwY9M16W6/BK/VWNUJnGSQLFItd46HR7gn2KrmX8tXITNNlb7eyhukRwVdd/ypvwjjVXy08QuMNWj5+rB7ZLvB8KlposhEyOsqDj6qQ15iCMHV9yhV8ITwv8F6UysqF0ZWF6+y5AlY9hT7Stw4gCUo2VPtSPjTCHJHM53DM0ojN/qmPv0UfNmqCyOlymGt1I4mRhdQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: g/ES9fRreXxBG5H9NYQ6QKlX8afwGFnVcCjmUmmQGFyMZJEJ+O5r0GxKN4y144Ul/2kveIzwph+nFKwMNsOuz51SDAN+7N7ni8asMIXb78j4DlUvWFTiHj8/xRPnazqKGIHHnbBzpr9LVQd04i7b75eGWeglvonzy2p/xet17JbfLfmHqcjrjZbI2AEGjEMn2ij7CILwLoW5TBOKR4+SMnt2j1FMlcshKh9UFirVjvaLnWTsvNue8VO5L23+m2YdRJf0ix9Tl7BGu2P1/2WFrOr9zJVhe8kqxUiUrp3GO9Tv/C921Zf5C5NNEr0LQPKIYcVm7Z+4b2WWEsWq8Gwn1qtFHcYrN6mxoAK92CrNXOKkDuml0XBz8i0DgVBKpSgsvHN2NzkEIWPIbRueFUKJptNjyQACoMWmKQJgCNLOLvz/T9u7VUXJZQwBt+WD0bwn
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2026 12:10:28.3143 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f2ce6ec-dedb-4723-3e15-08de8bf9d5d8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6262
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

This series adds PCIe host controller support for AMD Versal Gen 2 SoCs,
enabling NVMe boot on boards such as the VEK385.

Patch 1 introduces the driver (pcie_dw_amd.c), built on the existing
pcie_dw_common infrastructure.

Patch 2 adds the required MMU entries for the PCIe DBI registers.

Patch 3 enables the required Kconfig symbols in the defconfig and
extends amd_versal2.h to include BOOT_TARGET_DEVICES_NVME in the
distro boot target list when CONFIG_NVME is set.

Pranav Sanwal (3):
  pci: Add AMD Versal2 DW PCIe host controller driver
  arm: versal2: Map PCIe DBI and config regions when PCIe is enabled
  amd: versal2: Enable PCIe/NVMe support and add NVMe boot target

 MAINTAINERS                        |   5 +
 arch/arm/mach-versal2/cpu.c        |  16 +-
 configs/amd_versal2_virt_defconfig |   6 +
 drivers/pci/Kconfig                |  11 ++
 drivers/pci/Makefile               |   1 +
 drivers/pci/pcie_dw_amd.c          | 250 +++++++++++++++++++++++++++++
 include/configs/amd_versal2.h      |   7 +
 7 files changed, 295 insertions(+), 1 deletion(-)
 create mode 100644 drivers/pci/pcie_dw_amd.c

-- 
2.34.1

