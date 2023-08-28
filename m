Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F5CDC83F12
	for <u-boot@archiver.kernel.org>; Mon, 28 Aug 2023 14:30:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 51573864ED;
	Mon, 28 Aug 2023 16:30:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="163UB4iJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0075486505; Mon, 28 Aug 2023 16:30:52 +0200 (CEST)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20604.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::604])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 34E8980569
 for <u-boot@lists.denx.de>; Mon, 28 Aug 2023 16:30:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ngOJWRH7Spancg8ozryef4VcA1czqVXHj0LoEGKr5gp8oL0vSSOYZrD10/nlGfET9JLkYTNY/8IhpucrY+GQUY26ciiMwr/Ga7NONC8357XQ4fYEVFvZClRo9M3xi7Pla31/yvWL8pxfLED39t0xvz7IFxD2vnoSHG20LtUryfmR/JYiwvw+qKtSJdwGLFmre62/GcWy9/pPQC+Qde1MIPtZuJL0Hy8PU5rgAhH5d5SwVU/gwZzMlG3WDFDaFVQc5G5XcDbCkSXxAO0dyXnKxABBrath7V2DIDKWLghs1+uvhrmNsEuw9fHI0ZqNIuyBbRZn2Fl26EnGosYUIiBEnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L7AkmJIBlqMejNLnpW7LzHu1YSyANx28/rwOkDIZLww=;
 b=KmuORNMHtX9yqmv8SGrsfMZ/bSU50cCqikEZhR089M2641fhWAuaTsmlf10OQx6JEhKDrco/6BgL/oFgBrTKTywDCUWJlRD1m3iBtuALd4isaV9tf2E57ILvq9w/EUAeU4EY84ImdjH71yynX+7sWkTBWe61LwN1OtO25Wn8gryFT7k/1Wm9kRTMLBXwKAtmvgv7pOko6IWlesiQMyE0GhN88jKcbwTaSSe+rRC9wNTTzTaT/Z7kHBb9u2c5hCshDhZ4q17Iysa/M3L2wjYbfDyYkHZTHtkP7O+qWeLkGO5EWHPoERjcUhcz7XMb+M6Zypk/Hi2kf1Sy+6FvLaOPzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L7AkmJIBlqMejNLnpW7LzHu1YSyANx28/rwOkDIZLww=;
 b=163UB4iJ78JKJeoRSkWRr0JuK0M9SRBQ852zIkuVMelGGO2u1lSATN0lq8NwINT+1LvzAmGXqxB6KBAnjWdr1E7jI8K58/xakSylhgqTHrn2p/G19kti1V6cNIvgkKlVY7s7eaHFP+vkIuKwY0YOB0QRBW/rg17Za+DehE4qsyk=
Received: from MW2PR2101CA0025.namprd21.prod.outlook.com (2603:10b6:302:1::38)
 by CH3PR12MB9456.namprd12.prod.outlook.com (2603:10b6:610:1c2::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35; Mon, 28 Aug
 2023 14:30:46 +0000
Received: from CO1PEPF000044FB.namprd21.prod.outlook.com
 (2603:10b6:302:1:cafe::60) by MW2PR2101CA0025.outlook.office365.com
 (2603:10b6:302:1::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.7 via Frontend
 Transport; Mon, 28 Aug 2023 14:30:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044FB.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6768.2 via Frontend Transport; Mon, 28 Aug 2023 14:30:45 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 28 Aug
 2023 09:30:03 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Michal Simek <michal.simek@amd.com>
Subject: [U-BOOT TEST HOOKS PATCH] travis-ci: Do not run TPM tests on Versal
 QEMU target
Date: Mon, 28 Aug 2023 16:29:53 +0200
Message-ID: <add78a532efd5b822fe272f6440d923042b600f5.1693232991.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FB:EE_|CH3PR12MB9456:EE_
X-MS-Office365-Filtering-Correlation-Id: 442965fe-42e7-4a72-60ae-08dba7d35dfd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DwHqmo6oGbVajpu9AFZzddXZx+ZS6u79PurM/uKrjISs7e9NaIS1xfORXAYE9GuXNafdrflwkDE2zhZ2/08ys8vnQT7r5f1Oz590hWLAAcos8QX1OI8Yh4/VgFlf7t9fwplgAjtHAwNTa4kXONez8O36qPDDj20FzpHp5Jv3zCw2i1+shpbc1A2vgUoUKsPGg6Ehmf26+LioSHs4fXlDDY5w4Ei7lbu1tN5iVcUFpMtlMwT/4zdcc+XOIo31cRwAnED7GlB60XgJLAX2JijHKbVBlI34Am1eA4X4LdpuHN5avXvmkWHmcI014tLlxSkttJThzCnymjfKOr+ase1dJGZC+nOZnK80aHWRyCXgUaDIIP4mo/BUx2/G7P9iiA3aGWTJXZ+OKskV8Oc1ELMspCcJgRFYCkCSM8v6ShN9rED38hWK1LLB4mOLpKVahmiJu3yHP9qJN/pSpfg9tp5FUyCO2oRyz54Uibr9yFiHY4L/opVKLLBsBPaDp/xg28gzqvTbxbftTI6yJX1lOoLIzlAIoIW8WiqHmtg/tJS40ZMSMkzLxodvi4ktEEu/UTmiCuN9Xy72Ez47+leifqmVUnZVAd8RFhfDjHQXPfyOy9k7INqpQ6XqDGOMahJ7/Gri32ZvTtxH8HJ/UeBsvtZQz46A5ODB5i5sV5KmYO5XAeh9jKX2xfhPb64IbfgQAWV0a4eNluWSLmXn41MyPu7Yp1g1HDUwom/2oDqPZRLouVf3hbhhhAw7W/boaNvcxnpCvmFHuqKQNR+3hB/PPb9S3g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(346002)(396003)(136003)(376002)(82310400011)(1800799009)(186009)(451199024)(40470700004)(46966006)(36840700001)(6666004)(478600001)(2616005)(2906002)(336012)(426003)(26005)(16526019)(4744005)(316002)(70206006)(70586007)(110136005)(8936002)(44832011)(5660300002)(41300700001)(4326008)(8676002)(40460700003)(36756003)(40480700001)(356005)(47076005)(36860700001)(86362001)(81166007)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2023 14:30:45.7381 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 442965fe-42e7-4a72-60ae-08dba7d35dfd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044FB.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9456
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

TPM is going to be enabled by default but QEMU doesn't model it over SPI
that's why disable it for xilinx_versal_virt_qemu target.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 py/travis-ci/u_boot_boardenv_xilinx_versal_virt_qemu.py | 1 +
 1 file changed, 1 insertion(+)
 create mode 100644 py/travis-ci/u_boot_boardenv_xilinx_versal_virt_qemu.py

diff --git a/py/travis-ci/u_boot_boardenv_xilinx_versal_virt_qemu.py b/py/travis-ci/u_boot_boardenv_xilinx_versal_virt_qemu.py
new file mode 100644
index 000000000000..6fd75071ce0c
--- /dev/null
+++ b/py/travis-ci/u_boot_boardenv_xilinx_versal_virt_qemu.py
@@ -0,0 +1 @@
+env__tpm_device_test_skip=True
-- 
2.36.1

