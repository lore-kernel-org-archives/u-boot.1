Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16FA3CDB46E
	for <u-boot@archiver.kernel.org>; Thu, 12 Oct 2023 13:40:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB9E985F3D;
	Thu, 12 Oct 2023 15:40:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kMXG9RU1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 636DC863FD; Thu, 12 Oct 2023 15:40:19 +0200 (CEST)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2060b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::60b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9311380711
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 15:40:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oYTaW6U+vhlqtJ873CCKLj4pG6I1JG1KtFA2YSxwk623x89GTij5ntaf7XbeQniOs1n60MT6N2+OS0gywmCUZKLn4ydiptaPAqq6merPo8862Ef2LhDdP7u8VzL8bLgMuIIhhWJ39D0YfjeSp0jm1t3OFAl7T0oNw3TWmlQ146fakQdnaDP9W0t57KbKZgxgMIeKnaUo4fHZWDdJ9oDZ1jqv0+dFW0b+IFOJIy5t0itlD2OxKo36sQFbbN0v8zZs99I4XtnI+npUeXCIdm/TULY4Ig3ZotWLRln5fWOpztB6CCABZme41K/nSs3yJ+G3DLsJRKMMCU9IMp/cIRU0IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eso0BWUVL5PiTdW05HhtvHXaKsESExOSYO9E4vt8sNw=;
 b=aRVpLcexwgYxYxVeiKlDuSx0KOBQW9SwbmzhlYjfp9WKGvMXWiJEL5vBVLPBwvDHbPKVv2KPAB1WDN021kBG2NVCc1vP1faoPpCyd3rBwrPIj/IVOeYawL/rCRF81gwkwN2NFMnxXhIi7/1uIksx91MkGmuUIVqVW6ILWZnlmk90e27WBaJ9v1e6c65CY/7wb6KndDA6jhduCBCTIBCt7vsnD43NqZU8psU1v4T+6ua7Dg3eJTkIbDw2PoK0XLrwJsedtTJWweFIluiS5ZH0o3FBLLn91VDVZbSYwrAg/kYV8MppwrxQj5KGRAjEjm2do9lMsz9H03I8VPtYv0j6yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eso0BWUVL5PiTdW05HhtvHXaKsESExOSYO9E4vt8sNw=;
 b=kMXG9RU12HYNl9PsIBahAhlWyX7zlZuGYa04mi6rAwuJdYjDDJ3K2hVAJoJc/NtT1FBk331hged1vhW8mREuDBeoTtSfCUpFIoPVNGAT9Qa39LkNxIRf9oa8OFqR49mjxzM5bIreTsyJsjR5mrZDbNSTYMrgPO6+5pJvccMhlV4=
Received: from CY8PR12CA0054.namprd12.prod.outlook.com (2603:10b6:930:4c::17)
 by CH0PR12MB5156.namprd12.prod.outlook.com (2603:10b6:610:bb::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Thu, 12 Oct
 2023 13:39:58 +0000
Received: from CY4PEPF0000EE39.namprd03.prod.outlook.com
 (2603:10b6:930:4c:cafe::53) by CY8PR12CA0054.outlook.office365.com
 (2603:10b6:930:4c::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.30 via Frontend
 Transport; Thu, 12 Oct 2023 13:39:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE39.mail.protection.outlook.com (10.167.242.13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Thu, 12 Oct 2023 13:39:58 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 12 Oct
 2023 08:39:56 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Subject: [PATCH] ARM: zynq: Disable the config CONFIG_SPI_FLASH_USE_4K_SECTORS
Date: Thu, 12 Oct 2023 15:39:56 +0200
Message-ID: <8e5c2bf3b7e5f366c4e261e8055ea254bda53aa9.1697117993.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=831; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=FkQ2pklMi9UmH2W0CDGUZyKrBsv0Y74ysLiQCE/jRok=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhlT175qiLk/TPFPjTl3dH/pmcu6O7R2cgeHqPL6xZS9XV
 O7Yt9ywI5aFQZCJQVZMkUXa5sqZvZUzpghfPCwHM4eVCWQIAxenAExkKR/D/DCj9NKlz9t/+NYy
 cd1+uWV7Sq/JYoZ5lqH8XwpYpPZGmHl9MxYz2a8xad8zAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE39:EE_|CH0PR12MB5156:EE_
X-MS-Office365-Filtering-Correlation-Id: ee6a64fd-a5eb-4807-7aaa-08dbcb28b9f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hLka207HXHdmP5nh0Uxd/rRrQYncnK2YOWPvN+zgXOb8Njwdpbn/PBSZzwFpXZXVk47R6DrQ22r5PrvLyf8tsp9no4FPxzeRbcDXByDT2XsYhBeTWONnDoafEMPJuM9eKQ15v33xtjTe0zG9FhfZhJfH46Iyr96gL/8c8cR+f09HC8r/F9KZNFSpV2bDyLQxrTCHcwvex+hTRK2j5ZYfqX9+hsvti0ciLhebS4voLiZEBI+mvSb9Yi2Rzx4K7EeE+NCXqciG1B3j5pAVOj2W5PDyqGgGYkJD0hQIWLeAp2ClSLUPdCufMLYVAdjf+IARqsaXL8q5VOyf2htt1OU9V/T/CsdQ/SSb5GAZZ2G1rcXcgAeCF6ILU90fOJXRLTPw0p4muWu60IjHv9KfLphbg58a/lAdjPr+JP6JUycEYWfOf17bGnak7WRvwVeh8g1TWMfDmFN9Xssbz39ueAuMfebM6rfcuHjnvfb80WGFJNVJWuYQ8bqiVi+Ck0DIwE0V42zrV4dwRQCvT8B+RrnyBWpJhqgpcdvjooCupUE+9QRXdSKTN16ttfH+BrZBanGrz7Dn54iLV3EMEv/lapyky9T5j9ikorGwWiG8set/tqeezLlO+mDNh5DJNSI4oQcTUZoxuyQlRULoAOSinE+7rHPiiM7/jFEgWTf9r42IpODn1Koa+HYUmjuKk1WapgSnckcc7s3uzRbXoFoI9s5IkuxPO9ltIR95TtyM50osB3feJ4iLVVyyLevbrxg5I6mGXls/jZfFNFJOgz1Y+P0xZA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(376002)(346002)(136003)(396003)(230922051799003)(1800799009)(186009)(82310400011)(64100799003)(451199024)(40470700004)(46966006)(36840700001)(356005)(82740400003)(81166007)(40460700003)(478600001)(36860700001)(2906002)(83380400001)(47076005)(86362001)(2616005)(36756003)(426003)(336012)(26005)(16526019)(4744005)(40480700001)(4326008)(8676002)(8936002)(110136005)(70586007)(70206006)(316002)(41300700001)(44832011)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2023 13:39:58.1032 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee6a64fd-a5eb-4807-7aaa-08dbcb28b9f6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE39.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5156
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

From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>

Lock size for the flashes will be in terms of sector size, so
disable the CONFIG_SPI_FLASH_USE_4K_SECTORS and read it from the
flash itself.

Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 configs/xilinx_zynq_virt_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/xilinx_zynq_virt_defconfig b/configs/xilinx_zynq_virt_defconfig
index 817fb4142d18..6145af62b511 100644
--- a/configs/xilinx_zynq_virt_defconfig
+++ b/configs/xilinx_zynq_virt_defconfig
@@ -126,6 +126,7 @@ CONFIG_SPI_FLASH_SPANSION=y
 CONFIG_SPI_FLASH_STMICRO=y
 CONFIG_SPI_FLASH_SST=y
 CONFIG_SPI_FLASH_WINBOND=y
+# CONFIG_SPI_FLASH_USE_4K_SECTORS is not set
 CONFIG_PHY_MARVELL=y
 CONFIG_PHY_MICREL=y
 CONFIG_PHY_MICREL_KSZ90X1=y
-- 
2.36.1

