Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB28FC83F10
	for <u-boot@archiver.kernel.org>; Thu, 31 Aug 2023 12:39:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 36CB68659B;
	Thu, 31 Aug 2023 14:38:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mAS1YM1P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5E55A805C1; Thu, 31 Aug 2023 05:17:25 +0200 (CEST)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E6CAD8656A
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 05:17:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OVFlIuRzoZ/BCndJAk2Fm6NbyyDOjpgKRd8OYjQpF6hDn/WIFEvx7x23pmnWx9Awgn8xOD6vQpRw6MwE7C+lXxux55S6ibqE80d9pu0HCicnKRZiD+eZuIL6cVg0QMW9GEXCk8t1oAJ5y9kxtOwdIn3lBCPFLQHO0KuDrzM9fhEpwq82qV649g7civxMEjwT5frdpt2l7h2B+NXBzmrkktkCYWV/XqFVmp4VdJlfbGV1GWDbFqQLJokHXHsipipl/Ucauu55MgFx77i9GxqlmED8rCIwrvsLsNe0tVeFgmpz9EcJHyLDWRHb7/mVSsvrf/MJCjINu3EbZvMNRHScYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C55WRT1OHNfRoApUVre8Nvt1q/rsRZhfibWnHMuqPcU=;
 b=D3DPxdFtnNZGsbWNS6zvx/0zvbWNP5GKWR+FmR+CLq3T9QHOYkPa9rYf+2b+T6SuTZS+nGty5qIBk853epC1k6rEYnaCmrHn7Uemt0E6MTC/IbHLHtYnz2rbCHet5NxHtTehr/RB1d9EM/EUFk989gXIvCVHdIZBimCeBwbY3Ax/2+mUVCZpM9oEYE1h+X/CYfiO4lc+yP/mgU9pgB3nAVWEp5H0RTHb1hxIJX9z1bVAPUpa9kCG/m+bpzTyMwUUdYrRJMekSLdiJgZQ242SuZ58LeEWSMRGYegJXQnXjc2OqLrtNMwYRxHzIg4NJbFvxX0mvMDP2+Ytke1hBXAwVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C55WRT1OHNfRoApUVre8Nvt1q/rsRZhfibWnHMuqPcU=;
 b=mAS1YM1Pow+d/mWWHlbrywhaA8KLzeHvciiXSKLMyTpbMt6hUD01M9gyeuj6mLFpfmyl+GtUDOXCsC74sOkW2wOhSHahnsOKZ0FtW0J4+sMJ8We1Nfto96fVWHds9d5oFR/ni1g6vuO2STKla0lfolLB1g/rh/TkxE9YcX0kqe4=
Received: from CYZPR05CA0012.namprd05.prod.outlook.com (2603:10b6:930:89::22)
 by DM4PR12MB8572.namprd12.prod.outlook.com (2603:10b6:8:17d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35; Thu, 31 Aug
 2023 03:17:18 +0000
Received: from CY4PEPF0000EDD6.namprd03.prod.outlook.com
 (2603:10b6:930:89:cafe::e0) by CYZPR05CA0012.outlook.office365.com
 (2603:10b6:930:89::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.9 via Frontend
 Transport; Thu, 31 Aug 2023 03:17:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD6.mail.protection.outlook.com (10.167.241.210) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6745.17 via Frontend Transport; Thu, 31 Aug 2023 03:17:17 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 30 Aug
 2023 22:17:16 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 30 Aug
 2023 20:17:16 -0700
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27 via Frontend
 Transport; Wed, 30 Aug 2023 22:17:14 -0500
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <git@xilinx.com>
Subject: [PATCH 3/3] arm64: versal-net: Enable the config CMD_KASLRSEED
Date: Thu, 31 Aug 2023 08:46:58 +0530
Message-ID: <20230831031658.2203-4-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230831031658.2203-1-venkatesh.abbarapu@amd.com>
References: <20230831031658.2203-1-venkatesh.abbarapu@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD6:EE_|DM4PR12MB8572:EE_
X-MS-Office365-Filtering-Correlation-Id: 890012f3-e449-4303-62c8-08dba9d0c7cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Whz/T1yAvB/ioGhEUYdQ5EcaRGjgMYsu8Sj9Qui53KPMGfg98rp1ocfAOPiRVqR8R2aRcRS7Q8Z0zxppgx3qUvmXeeqd/UG7nXp9ZkI2YswL1FzE7059Xkn5JDr3PK2cM270E7x3beU4PrCcWCjbZMt+H2eJVA/JZtkIwmmTSN0q43H33vxqq6PjDv3GhpU85VKBhbundglpBEi1q/SZNUgQVQ2Lx/An1wY/WG7g4jBKcSTmDHFy8s2pz/BDoJ/eFQcxz2p3AFSZxuhrIYtr9tZreAMakB57j3knoTOD+7YE8wh/MTTlB74tGelRGhzRYdPBWereqVq6lJWY5yeSD9te7+/sNW7LrxTvPelZvQXTizt+yrtqvKJPlGt7mLvVBx8KC4dc9eLZqGwAV+Zd7dUl2nf+2aZ/Q1MoyMw2pd23h6xHeG4pbGi9NY9JQor9ECy0cLsdQTlabGuJqONHX1a5UAjUmn8GTJUTM+IwzJcb5DcqTnE2U2MHN2x/no58R+HaHtoSaYGzf5lJh/cXJwOMLxRmKMYK8rOvDCQ4NM066xk/2HdBpRbF2QaMZNNoOakTbjPYS3qROBgHmQutaq1rDBqEXWwR5s1lK0UySS3/dk29Kww/PRVkLHujQbbYV4S2gKgHBgSEmCYtUVG5bn1rTlP2T4mEOq0nDRAEiJFuUlCSrD/KLtM7kS6h5m7nis9JgdYH+2ShWN3sgANXESgei8kwz1Vpz5R5kgmiJApkCYvdIVMZPNuYbHKR+GjAYVQxcWmm8xtpLLAHajFlgw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(376002)(136003)(346002)(396003)(82310400011)(451199024)(1800799009)(186009)(40470700004)(46966006)(36840700001)(426003)(40460700003)(316002)(41300700001)(336012)(5660300002)(4326008)(47076005)(107886003)(2616005)(83380400001)(8676002)(86362001)(26005)(36756003)(1076003)(36860700001)(6916009)(2906002)(40480700001)(8936002)(6666004)(356005)(82740400003)(81166007)(54906003)(70206006)(70586007)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2023 03:17:17.2512 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 890012f3-e449-4303-62c8-08dba9d0c7cf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8572
X-Mailman-Approved-At: Thu, 31 Aug 2023 14:38:51 +0200
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

Kernel Address Space Layout Randomization (KASLR) is a hardening
feature that aims to make it more difficult to take advantage
of known exploits in the kernel, by placing kernel data
structures at a random address at each boot.The bootloader
supports randomizing the virtual address at which the kernel image
is loaded. The bootloader must provide entropy by passing a random
u64 value in the /chosen/kaslr-seed device tree node.
When we run "kaslrseed" command from U-Boot, the bootloader will
genarate the kaslr-seed and update the /chosen/kaslr-seed DT property.

Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
---
 configs/xilinx_versal_net_virt_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/xilinx_versal_net_virt_defconfig b/configs/xilinx_versal_net_virt_defconfig
index 7d1ca8cf27..cc4e3da792 100644
--- a/configs/xilinx_versal_net_virt_defconfig
+++ b/configs/xilinx_versal_net_virt_defconfig
@@ -50,6 +50,7 @@ CONFIG_CMD_CACHE=y
 CONFIG_CMD_EFIDEBUG=y
 CONFIG_CMD_TIME=y
 CONFIG_CMD_RNG=y
+CONFIG_CMD_KASLRSEED=y
 CONFIG_CMD_TIMER=y
 CONFIG_CMD_SMC=y
 CONFIG_CMD_TPM=y
-- 
2.17.1

